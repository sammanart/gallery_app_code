import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/src/config/app_colors.dart';
import 'package:image_gallery/src/config/app_spacing.dart';
import 'package:image_gallery/src/core/injector/injector.dart';
import 'package:image_gallery/src/domain/use_cases/image_loader.dart';
import 'package:image_gallery/src/presentation/widgets/full_screen_image.dart';
import 'package:image_gallery/src/presentation/widgets/likes_comments_count.dart';
import 'package:image_gallery/src/presentation/widgets/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../cubit/image/image_cubit.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({super.key});
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: BlocProvider<ImageCubit>(
        lazy: true,
        create: (context) => ImageCubit(injector<ImageLoader>())..getImages(),
        child: BlocBuilder<ImageCubit, ImageState>(builder: (context, state) {
          if (state is ImageLoading &&
              (state.imageMainState.imageList?.isEmpty ?? true) &&
              textEditingController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImageError) {
            return Center(child: Text(state.error));
          }

          final width = MediaQuery.of(context).size.width;
          final crossAxisCount = (width / 100).floor();
          return LazyLoadScrollView(
            isLoading: state is LazyImageLoading,
            onEndOfPage: () {
              context.read<ImageCubit>().lazyLoadImages();
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.eight),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sixteen),
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        final searchValue = value.trim();
                        context.read<ImageCubit>().searchImages(searchValue);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search images',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: AppSpacing.sixteen,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (state is ImageLoading) {
                        return const Loading();
                      } else if (state.imageMainState.imageList?.isEmpty ??
                          true) {
                        return const Center(child: Text('No images'));
                      }
                      return GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 1,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: state.imageMainState.imageList?.length,
                        itemBuilder: (context, index) {
                          var image = state.imageMainState.imageList![index];
                          return InkWell(
                            onTap: () => _showFullScreenImageDialog(
                              context,
                              image.largeImageURL ??
                                  image.imageURL ??
                                  image.previewURL ??
                                  '',
                            ),
                            child: Hero(
                              tag: image.largeImageURL ??
                                  image.imageURL ??
                                  image.previewURL ??
                                  '',
                              child: GridTile(
                                footer: Container(
                                    height: 40,
                                    color: AppColors.black.withOpacity(0.6),
                                    child: LikesCommentsCount(
                                      likes: image.likes ?? 0,
                                      comments: image.comments ?? 0,
                                    )),
                                child: Image.network(
                                  image.imageURL ?? image.previewURL ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  if (state is LazyImageLoading)
                    const Padding(
                      padding: EdgeInsets.all(AppSpacing.eight),
                      child: SafeArea(
                        child: Loading(),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _showFullScreenImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) => FullScreenImageDialog(
        imageUrl: imageUrl,
      ),
    );
  }
}
