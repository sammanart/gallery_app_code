import 'package:flutter/material.dart';
import 'package:image_gallery/src/core/galley_app.dart';
import 'src/core/injector/injector.dart' as service_locator;

Future<void> main() async {
  await service_locator.call();
  await service_locator.injector.allReady();

  runApp(const GalleryApp());
}
