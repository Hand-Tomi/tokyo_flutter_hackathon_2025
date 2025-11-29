import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// 오디오 녹음 서비스
/// record 패키지를 래핑하여 녹음 기능을 제공합니다.
class AudioRecorderService {
  AudioRecorder? _recorder;
  bool _isRecording = false;
  String? _currentPath;

  /// 새 레코더 인스턴스 생성 (매 녹음마다)
  Future<AudioRecorder> _createNewRecorder() async {
    // 기존 레코더 정리
    if (_recorder != null) {
      try {
        await _recorder!.dispose();
      } catch (_) {}
      _recorder = null;
    }
    _recorder = AudioRecorder();
    return _recorder!;
  }

  /// 마이크 권한 확인
  Future<bool> hasPermission() async {
    final recorder = _recorder ?? AudioRecorder();
    final result = await recorder.hasPermission();
    if (_recorder == null) {
      await recorder.dispose();
    }
    return result;
  }

  /// 녹음 시작
  /// [fileName]: 확장자 없는 파일명
  /// 저장 경로: Documents/media/records/[fileName].m4a
  Future<String> startRecording(String fileName) async {
    // 이미 녹음 중이면 먼저 중지
    if (_isRecording) {
      await stopRecording();
    }

    final dir = await getApplicationDocumentsDirectory();
    final recordsDir = Directory('${dir.path}/media/records');

    if (!await recordsDir.exists()) {
      await recordsDir.create(recursive: true);
    }

    // FLAC 형식 - gpt-4o-transcribe API 호환, 무손실 압축
    final path = '${recordsDir.path}/$fileName.flac';
    _currentPath = path;

    // 매번 새 레코더 인스턴스 생성
    final recorder = await _createNewRecorder();

    await recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.flac,
        sampleRate: 16000,
        numChannels: 1, // 모노 채널 - 음성 인식에 적합
      ),
      path: path,
    );

    _isRecording = true;
    return path;
  }

  /// 녹음 중지
  /// 반환: 저장된 파일 경로 (null이면 녹음 실패)
  Future<String?> stopRecording() async {
    if (!_isRecording || _recorder == null) {
      return _currentPath;
    }

    try {
      final path = await _recorder!.stop();
      _isRecording = false;

      // 녹음 완료 후 레코더 정리
      try {
        await _recorder!.dispose();
      } catch (_) {}
      _recorder = null;

      return path ?? _currentPath;
    } catch (e) {
      _isRecording = false;
      _recorder = null;
      return _currentPath;
    }
  }

  /// 녹음 중 여부 확인
  bool get isRecording => _isRecording;

  /// 리소스 해제
  Future<void> dispose() async {
    if (_isRecording) {
      await stopRecording();
    }
    try {
      await _recorder?.dispose();
    } catch (_) {}
    _recorder = null;
  }
}
