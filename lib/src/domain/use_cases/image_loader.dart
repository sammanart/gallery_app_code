import 'package:image_gallery/src/data/models/image_model.dart';
import 'package:image_gallery/src/domain/repositories/image_repository.dart';

class ImageLoader {
  final ImageRepository repository;

  ImageLoader(this.repository);

  Future<List<ImageModel>> call(
    int page, {
    String? query,
  }) {
    return repository.getImages(page, query: query);
  }
}
