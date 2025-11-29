/// 공유 포맷터 유틸리티
///
/// DRY 원칙 준수를 위해 중복 포맷터 함수들을 통합
class Formatters {
  Formatters._();

  /// 파일 크기를 읽기 쉬운 형식으로 변환
  ///
  /// 예: 1024 → "1.0 KB", 1048576 → "1.0 MB"
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// 밀리초 단위 시간을 mm:ss 형식으로 변환
  ///
  /// 예: 120000 → "02:00"
  static String formatDuration(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// DateTime을 yyyy/MM/dd HH:mm 형식으로 변환
  ///
  /// 예: DateTime(2024, 11, 20, 14, 30) → "2024/11/20 14:30"
  static String formatDateTime(DateTime dateTime) {
    final year = dateTime.year;
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$year/$month/$day $hour:$minute';
  }
}
