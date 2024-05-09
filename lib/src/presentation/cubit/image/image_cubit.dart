import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_gallery/src/data/models/image_model.dart';
import 'package:image_gallery/src/domain/use_cases/image_loader.dart';
import 'package:image_gallery/src/utils/debouncer.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImageLoader imageLoader;
  final Debouncer debouncer = Debouncer(milliseconds: 500);

  ImageCubit(this.imageLoader) : super(const ImageInitial());

  Future<void> getImages() async {
    try {
      emit(ImageLoading(state.imageMainState));
      final images = await imageLoader(state.imageMainState.page);
      emit(ImageLoaded(state.imageMainState.copyWith(
        imageList: images,
      )));
    } catch (e) {
      emit(
        ImageError(state.imageMainState, e.toString()),
      );
    }
  }

  Future<void> lazyLoadImages() async {
    var page = state.imageMainState.page;
    page++;

    try {
      emit(LazyImageLoading(state.imageMainState));
      final images = await imageLoader(page);
      final currentImages = List<ImageModel>.from(
        state.imageMainState.imageList ?? <ImageModel>[],
      );
      currentImages.addAll(images);

      emit(
        LazyImageLoaded(
          state.imageMainState.copyWith(
            imageList: currentImages,
            page: page,
          ),
        ),
      );
    } catch (e) {
      emit(
        LazyImageError(state.imageMainState, e.toString()),
      );
    }
  }

  Future<void> searchImages(String searchValue) async {
    debouncer.run(() async {
      const page = 1;

      try {
        emit(
          ImageLoading(
            state.imageMainState.copyWith(
              page: page,
            ),
          ),
        );
        final images = await imageLoader(page, query: searchValue);
        emit(
          ImageLoaded(state.imageMainState.copyWith(imageList: images)),
        );
      } catch (e) {
        emit(ImageError(state.imageMainState, e.toString()));
      }
    });
  }
}
