import 'package:flutter/material.dart';

/// Web stub - always returns network image or placeholder
Widget buildFileImage({
  required String path,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  required Widget Function() errorBuilder,
}) {
  if (path.isEmpty) {
    return errorBuilder();
  }

  // 웹에서 blob URL은 Image.network로 로드 가능
  return Image.network(
    path,
    fit: fit,
    width: width,
    height: height,
    errorBuilder: (context, error, stackTrace) => errorBuilder(),
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    },
  );
}
