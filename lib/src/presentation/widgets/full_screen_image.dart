import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/src/config/app_colors.dart';
import 'package:image_gallery/src/config/app_spacing.dart';
import 'package:image_gallery/src/presentation/widgets/loading.dart';

class FullScreenImageDialog extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageDialog({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(AppSpacing.eight),
      child: Column(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.eight),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.black,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.eight),
              child: Hero(
                tag: imageUrl,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Loading(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
