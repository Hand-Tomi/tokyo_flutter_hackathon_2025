/// 음성-텍스트 변환(STT) 서비스의 추상 인터페이스
abstract class SttService {
  /// 오디오 파일을 텍스트로 변환합니다.
  ///
  /// [audioPath]: 변환할 오디오 파일 경로
  ///
  /// 반환: 변환된 텍스트
  ///
  /// 예외: 변환 실패 시 Exception 발생
  Future<String> transcribe(String audioPath);
}
