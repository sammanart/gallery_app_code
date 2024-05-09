import 'package:flutter/material.dart';
import 'package:image_gallery/src/presentation/pages/gallery_page.dart';

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery',
      home: GalleryPage(),
    );
  }
}
