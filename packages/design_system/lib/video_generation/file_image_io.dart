import 'dart:io';

import 'package:flutter/material.dart';

/// Mobile implementation - uses dart:io File
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

  final file = File(path);
  if (!file.existsSync()) {
    return errorBuilder();
  }

  return Image.file(
    file,
    fit: fit,
    width: width,
    height: height,
    errorBuilder: (context, error, stackTrace) => errorBuilder(),
  );
}
