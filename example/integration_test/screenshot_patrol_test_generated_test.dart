import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../lib/main.dart' as app;

Future<void> takeAutoTestScreenshot(
  PatrolIntegrationTester $,
  String name,
) async {
  final TestWidgetsFlutterBinding binding = $.tester.binding;
  final RenderView renderView = binding.renderViews.first;
  final ContainerLayer? layer = renderView.debugLayer;
  if (layer == null) {
    throw StateError(
      'AutoTest could not capture a screenshot before the first frame was painted.',
    );
  }

  final ui.Scene scene = layer.buildScene(ui.SceneBuilder());
  final ui.Size physicalSize = renderView.flutterView.physicalSize;
  final ui.Image image = await scene.toImage(
    physicalSize.width.ceil(),
    physicalSize.height.ceil(),
  );
  scene.dispose();
  try {
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw StateError('AutoTest screenshot capture returned no PNG bytes.');
    }
    final Uint8List bytes = byteData.buffer.asUint8List();
    final Directory outputDir = await _patrolScreenshotDir();
    final String safeName =
        name.replaceAll(RegExp(r'[^a-zA-Z0-9_.-]'), '_');
    await File('${outputDir.path}/$safeName.png')
        .writeAsBytes(bytes, flush: true);
  } finally {
    image.dispose();
  }
}

Future<Directory> _patrolScreenshotDir() async {
  const String explicitDir =
      String.fromEnvironment('AUTO_TEST_PATROL_SCREENSHOT_DIR');
  if (explicitDir.isNotEmpty) {
    try {
      final Directory dir = Directory(explicitDir);
      await dir.create(recursive: true);
      return dir;
    } on FileSystemException {
      // iOS/macOS sandboxed test apps may not be allowed to write
      // directly to the host project. Fall back to the app temp dir.
    }
  }
  final Directory dir = Directory(
    '${Directory.systemTemp.path}/auto_test_patrol_screenshots',
  );
  await dir.create(recursive: true);
  return dir;
}

void main() {
  patrolTest('launch app and capture first screenshot', ($) async {
    $.log('AutoTest: launching app');
    await Future<void>.sync(app.main).timeout(const Duration(seconds: 5));

    $.log('AutoTest: pumping initial frames');
    for (int attempt = 0; attempt < 20; attempt++) {
      await $.pump(const Duration(milliseconds: 100));
      final TestWidgetsFlutterBinding binding = $.tester.binding;
      if (binding.renderViews.isNotEmpty &&
          binding.renderViews.first.debugLayer != null) {
        break;
      }
    }

    $.log('AutoTest: capturing screenshot');
    await takeAutoTestScreenshot($, 'app_launch')
        .timeout(const Duration(seconds: 10));
    $.log('AutoTest: screenshot captured');
  });
}
