package com.example.flutter_architecture_sample

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutter_architecture_sample/gesture_recognizer"
    private var gestureRecognizerHelper: GestureRecognizerHelper? = null

    companion object {
        private const val TAG = "MainActivity"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    try {
                        if (gestureRecognizerHelper == null) {
                            gestureRecognizerHelper = GestureRecognizerHelper(
                                context = this,
                                gestureRecognizerListener = object : GestureRecognizerHelper.GestureRecognizerListener {
                                    override fun onError(error: String) {
                                        Log.e(TAG, "GestureRecognizer error: $error")
                                    }

                                    override fun onResults(resultMap: Map<String, Any>) {
                                        // Results handled synchronously
                                    }
                                }
                            )
                        }
                        result.success(gestureRecognizerHelper?.isReady() == true)
                    } catch (e: Exception) {
                        result.error("INIT_ERROR", e.message, null)
                    }
                }

                "recognizeGesture" -> {
                    try {
                        val args = call.arguments as? Map<*, *>
                        if (args == null) {
                            result.error("INVALID_ARGS", "Arguments cannot be null", null)
                            return@setMethodCallHandler
                        }

                        val yBuffer = args["yBuffer"] as? ByteArray
                        val uBuffer = args["uBuffer"] as? ByteArray
                        val vBuffer = args["vBuffer"] as? ByteArray
                        val width = args["width"] as? Int
                        val height = args["height"] as? Int
                        val yRowStride = args["yRowStride"] as? Int
                        val uvRowStride = args["uvRowStride"] as? Int
                        val uvPixelStride = args["uvPixelStride"] as? Int
                        val rotationDegrees = args["rotationDegrees"] as? Int ?: 0

                        if (yBuffer == null || uBuffer == null || vBuffer == null ||
                            width == null || height == null ||
                            yRowStride == null || uvRowStride == null || uvPixelStride == null) {
                            result.error("INVALID_ARGS", "Missing required image data", null)
                            return@setMethodCallHandler
                        }

                        val recognitionResult = gestureRecognizerHelper?.recognizeFromYuv(
                            yBuffer = yBuffer,
                            uBuffer = uBuffer,
                            vBuffer = vBuffer,
                            width = width,
                            height = height,
                            yRowStride = yRowStride,
                            uvRowStride = uvRowStride,
                            uvPixelStride = uvPixelStride,
                            rotationDegrees = rotationDegrees
                        )

                        result.success(recognitionResult)
                    } catch (e: Exception) {
                        Log.e(TAG, "Recognition error: ${e.message}")
                        result.error("RECOGNITION_ERROR", e.message, null)
                    }
                }

                "close" -> {
                    try {
                        gestureRecognizerHelper?.close()
                        gestureRecognizerHelper = null
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("CLOSE_ERROR", e.message, null)
                    }
                }

                "isReady" -> {
                    result.success(gestureRecognizerHelper?.isReady() == true)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onDestroy() {
        gestureRecognizerHelper?.close()
        gestureRecognizerHelper = null
        super.onDestroy()
    }
}
