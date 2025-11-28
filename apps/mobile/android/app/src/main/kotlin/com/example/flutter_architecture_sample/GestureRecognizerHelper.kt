package com.example.flutter_architecture_sample

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.ImageFormat
import android.graphics.Matrix
import android.graphics.Rect
import android.graphics.YuvImage
import android.util.Log
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.core.Delegate
import com.google.mediapipe.tasks.vision.gesturerecognizer.GestureRecognizer
import com.google.mediapipe.tasks.vision.gesturerecognizer.GestureRecognizerResult
import com.google.mediapipe.tasks.vision.core.RunningMode
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

/**
 * Helper class for MediaPipe Gesture Recognizer
 * Provides gesture recognition from camera frames
 */
class GestureRecognizerHelper(
    private val context: Context,
    private val gestureRecognizerListener: GestureRecognizerListener? = null
) {
    private var gestureRecognizer: GestureRecognizer? = null

    companion object {
        private const val TAG = "GestureRecognizerHelper"
        private const val MP_GESTURE_RECOGNIZER_TASK = "gesture_recognizer.task"

        // Lower confidence thresholds for better detection
        private const val DEFAULT_HAND_DETECTION_CONFIDENCE = 0.3f
        private const val DEFAULT_HAND_TRACKING_CONFIDENCE = 0.3f
        private const val DEFAULT_HAND_PRESENCE_CONFIDENCE = 0.3f
        private const val DEFAULT_NUM_HANDS = 2
    }

    init {
        setupGestureRecognizer()
    }

    /**
     * Initialize the Gesture Recognizer with options
     */
    private fun setupGestureRecognizer() {
        try {
            // Try GPU first, fallback to CPU
            var delegate = Delegate.GPU
            var gestureRecognizerLocal: GestureRecognizer? = null

            try {
                val gpuBaseOptions = BaseOptions.builder()
                    .setModelAssetPath(MP_GESTURE_RECOGNIZER_TASK)
                    .setDelegate(Delegate.GPU)
                    .build()

                val gpuOptions = GestureRecognizer.GestureRecognizerOptions.builder()
                    .setBaseOptions(gpuBaseOptions)
                    .setMinHandDetectionConfidence(DEFAULT_HAND_DETECTION_CONFIDENCE)
                    .setMinTrackingConfidence(DEFAULT_HAND_TRACKING_CONFIDENCE)
                    .setMinHandPresenceConfidence(DEFAULT_HAND_PRESENCE_CONFIDENCE)
                    .setNumHands(DEFAULT_NUM_HANDS)
                    .setRunningMode(RunningMode.IMAGE)
                    .build()

                gestureRecognizerLocal = GestureRecognizer.createFromOptions(context, gpuOptions)
                Log.d(TAG, "GestureRecognizer initialized with GPU delegate")
            } catch (gpuError: Exception) {
                Log.w(TAG, "GPU delegate failed, trying CPU: ${gpuError.message}")
                delegate = Delegate.CPU

                val cpuBaseOptions = BaseOptions.builder()
                    .setModelAssetPath(MP_GESTURE_RECOGNIZER_TASK)
                    .setDelegate(Delegate.CPU)
                    .build()

                val cpuOptions = GestureRecognizer.GestureRecognizerOptions.builder()
                    .setBaseOptions(cpuBaseOptions)
                    .setMinHandDetectionConfidence(DEFAULT_HAND_DETECTION_CONFIDENCE)
                    .setMinTrackingConfidence(DEFAULT_HAND_TRACKING_CONFIDENCE)
                    .setMinHandPresenceConfidence(DEFAULT_HAND_PRESENCE_CONFIDENCE)
                    .setNumHands(DEFAULT_NUM_HANDS)
                    .setRunningMode(RunningMode.IMAGE)
                    .build()

                gestureRecognizerLocal = GestureRecognizer.createFromOptions(context, cpuOptions)
                Log.d(TAG, "GestureRecognizer initialized with CPU delegate")
            }

            gestureRecognizer = gestureRecognizerLocal
            Log.d(TAG, "GestureRecognizer initialized successfully with $delegate delegate")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to initialize GestureRecognizer: ${e.message}")
            gestureRecognizerListener?.onError("Gesture recognizer initialization failed: ${e.message}")
        }
    }

    /**
     * Recognize gestures from a camera image (YUV format)
     * @param yBuffer Y plane bytes
     * @param uBuffer U plane bytes
     * @param vBuffer V plane bytes
     * @param width Image width
     * @param height Image height
     * @param rotationDegrees Camera rotation in degrees
     * @return GestureRecognizerResult or null if failed
     */
    fun recognizeFromYuv(
        yBuffer: ByteArray,
        uBuffer: ByteArray,
        vBuffer: ByteArray,
        width: Int,
        height: Int,
        yRowStride: Int,
        uvRowStride: Int,
        uvPixelStride: Int,
        rotationDegrees: Int
    ): Map<String, Any>? {
        if (gestureRecognizer == null) {
            Log.e(TAG, "GestureRecognizer is not initialized")
            return null
        }

        try {
            // Debug log rotation
            Log.d(TAG, "Input: ${width}x${height}, rotation: $rotationDegrees degrees")

            // Convert YUV to Bitmap
            val bitmap = yuv420ToBitmap(
                yBuffer, uBuffer, vBuffer,
                width, height,
                yRowStride, uvRowStride, uvPixelStride
            ) ?: return null

            Log.d(TAG, "Bitmap created: ${bitmap.width}x${bitmap.height}")

            // Rotate bitmap according to camera orientation
            val rotatedBitmap = rotateBitmap(bitmap, rotationDegrees)

            Log.d(TAG, "Rotated bitmap: ${rotatedBitmap.width}x${rotatedBitmap.height}")

            // Create MPImage from Bitmap
            val mpImage = BitmapImageBuilder(rotatedBitmap).build()

            // Run gesture recognition
            val result = gestureRecognizer?.recognize(mpImage)

            // Log all detected gestures with scores
            if (result != null && result.gestures().isNotEmpty()) {
                for (i in result.gestures().indices) {
                    val gestures = result.gestures()[i]
                    Log.d(TAG, "Hand $i gestures:")
                    for (gesture in gestures) {
                        Log.d(TAG, "  - ${gesture.categoryName()}: ${gesture.score()}")
                    }
                }
            }

            // Clean up
            if (rotatedBitmap != bitmap) {
                rotatedBitmap.recycle()
            }
            bitmap.recycle()

            return result?.let { parseResult(it) }
        } catch (e: Exception) {
            Log.e(TAG, "Error during gesture recognition: ${e.message}")
            return null
        }
    }

    /**
     * Recognize gestures from a Bitmap
     */
    fun recognizeFromBitmap(bitmap: Bitmap, rotationDegrees: Int = 0): Map<String, Any>? {
        if (gestureRecognizer == null) {
            Log.e(TAG, "GestureRecognizer is not initialized")
            return null
        }

        try {
            val rotatedBitmap = if (rotationDegrees != 0) {
                rotateBitmap(bitmap, rotationDegrees)
            } else {
                bitmap
            }

            val mpImage = BitmapImageBuilder(rotatedBitmap).build()
            val result = gestureRecognizer?.recognize(mpImage)

            if (rotatedBitmap != bitmap) {
                rotatedBitmap.recycle()
            }

            return result?.let { parseResult(it) }
        } catch (e: Exception) {
            Log.e(TAG, "Error during gesture recognition: ${e.message}")
            return null
        }
    }

    /**
     * Parse GestureRecognizerResult to Map for Flutter
     */
    private fun parseResult(result: GestureRecognizerResult): Map<String, Any> {
        val hands = mutableListOf<Map<String, Any>>()

        for (i in result.gestures().indices) {
            val gestures = result.gestures()[i]
            val handedness = result.handednesses()[i]
            val landmarks = result.landmarks()[i]

            val handData = mutableMapOf<String, Any>()

            // Gesture info (top gesture)
            if (gestures.isNotEmpty()) {
                val topGesture = gestures[0]
                handData["gesture"] = topGesture.categoryName()
                handData["gestureScore"] = topGesture.score()

                // Include all gesture candidates for debugging
                val allGestures = mutableListOf<Map<String, Any>>()
                for (gesture in gestures) {
                    allGestures.add(mapOf(
                        "name" to gesture.categoryName(),
                        "score" to gesture.score()
                    ))
                }
                handData["allGestures"] = allGestures
            } else {
                handData["gesture"] = "None"
                handData["gestureScore"] = 0.0f
                handData["allGestures"] = emptyList<Map<String, Any>>()
            }

            // Handedness (Left/Right)
            if (handedness.isNotEmpty()) {
                handData["handedness"] = handedness[0].categoryName()
                handData["handednessScore"] = handedness[0].score()
            }

            // Landmarks (21 points)
            val landmarkList = mutableListOf<Map<String, Float>>()
            for (landmark in landmarks) {
                landmarkList.add(mapOf(
                    "x" to landmark.x(),
                    "y" to landmark.y(),
                    "z" to landmark.z()
                ))
            }
            handData["landmarks"] = landmarkList

            hands.add(handData)
        }

        return mapOf(
            "hands" to hands,
            "timestamp" to result.timestampMs()
        )
    }

    /**
     * Convert YUV420 to Bitmap
     */
    private fun yuv420ToBitmap(
        yBuffer: ByteArray,
        uBuffer: ByteArray,
        vBuffer: ByteArray,
        width: Int,
        height: Int,
        yRowStride: Int,
        uvRowStride: Int,
        uvPixelStride: Int
    ): Bitmap? {
        try {
            // Create NV21 byte array
            val nv21 = ByteArray(width * height * 3 / 2)

            // Copy Y plane
            if (yRowStride == width) {
                System.arraycopy(yBuffer, 0, nv21, 0, width * height)
            } else {
                for (row in 0 until height) {
                    System.arraycopy(
                        yBuffer, row * yRowStride,
                        nv21, row * width,
                        width
                    )
                }
            }

            // Interleave U and V (NV21 format: VU)
            val uvHeight = height / 2
            val uvWidth = width / 2
            var uvIndex = width * height

            for (row in 0 until uvHeight) {
                for (col in 0 until uvWidth) {
                    val vIndex = row * uvRowStride + col * uvPixelStride
                    val uIndex = row * uvRowStride + col * uvPixelStride

                    if (vIndex < vBuffer.size && uIndex < uBuffer.size) {
                        nv21[uvIndex++] = vBuffer[vIndex]
                        nv21[uvIndex++] = uBuffer[uIndex]
                    }
                }
            }

            // Convert NV21 to JPEG then to Bitmap
            val yuvImage = YuvImage(nv21, ImageFormat.NV21, width, height, null)
            val out = ByteArrayOutputStream()
            yuvImage.compressToJpeg(Rect(0, 0, width, height), 90, out)
            val imageBytes = out.toByteArray()

            return BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
        } catch (e: Exception) {
            Log.e(TAG, "Error converting YUV to Bitmap: ${e.message}")
            return null
        }
    }

    /**
     * Rotate bitmap for correct orientation
     */
    private fun rotateBitmap(bitmap: Bitmap, degrees: Int): Bitmap {
        if (degrees == 0) return bitmap

        val matrix = Matrix()
        matrix.postRotate(degrees.toFloat())

        return Bitmap.createBitmap(
            bitmap, 0, 0,
            bitmap.width, bitmap.height,
            matrix, true
        )
    }

    /**
     * Close the gesture recognizer and release resources
     */
    fun close() {
        try {
            gestureRecognizer?.close()
            gestureRecognizer = null
            Log.d(TAG, "GestureRecognizer closed")
        } catch (e: Exception) {
            Log.e(TAG, "Error closing GestureRecognizer: ${e.message}")
        }
    }

    /**
     * Check if gesture recognizer is ready
     */
    fun isReady(): Boolean = gestureRecognizer != null

    /**
     * Listener interface for gesture recognition events
     */
    interface GestureRecognizerListener {
        fun onError(error: String)
        fun onResults(resultMap: Map<String, Any>)
    }
}
