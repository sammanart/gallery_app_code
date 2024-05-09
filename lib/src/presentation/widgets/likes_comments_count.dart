import 'package:flutter/material.dart';
import 'package:image_gallery/src/config/app_spacing.dart';
import 'package:image_gallery/src/config/theme.dart';

class LikesCommentsCount extends StatelessWidget {
  final int likes;
  final int comments;
  const LikesCommentsCount({
    super.key,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.eight),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.eight,
                  right: AppSpacing.sixteen,
                ),
                child: Text(
                  "$likes",
                  style: heading1,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.four),
          Row(
            children: [
              const Icon(
                Icons.comment,
                color: Colors.white,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.eight,
                ),
                child: Text(
                  "$comments",
                  style: heading1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
