part of 'image_cubit.dart';

class ImageMainState extends Equatable {
  final int page;
  final List<ImageModel>? imageList;
  const ImageMainState({
    this.page = 1,
    this.imageList,
  });

  ImageMainState copyWith({
    int? page,
    List<ImageModel>? imageList,
  }) {
    return ImageMainState(
      page: page ?? this.page,
      imageList: imageList ?? this.imageList,
    );
  }

  @override
  List<Object?> get props => [
        page,
        imageList,
      ];
}

abstract class ImageState extends Equatable {
  final ImageMainState imageMainState;

  const ImageState(this.imageMainState);
  @override
  List<Object> get props => [imageMainState];
}

class ImageInitial extends ImageState {
  const ImageInitial() : super(const ImageMainState());
}

class ImageLoading extends ImageState {
  const ImageLoading(super.imageMainState);
}

class ImageLoaded extends ImageState {
  const ImageLoaded(super.imageMainState);
}

class ImageError extends ImageState {
  final String error;
  const ImageError(super.imageMainState, this.error);
}

class LazyImageLoading extends ImageState {
  const LazyImageLoading(super.imageMainState);
}

class LazyImageLoaded extends ImageState {
  const LazyImageLoaded(super.imageMainState);
}

class LazyImageError extends ImageState {
  final String error;
  const LazyImageError(super.imageMainState, this.error);
}
