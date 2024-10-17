import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension SnapshotCreator on GlobalKey {
  Future<Image> createSnapshot() async {
    final boundary =
        currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return Image.memory(byteData!.buffer.asUint8List());
  }
}
