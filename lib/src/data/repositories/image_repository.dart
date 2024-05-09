import 'package:image_gallery/src/data/datasources/image_api.dart';
import 'package:image_gallery/src/data/models/image_model.dart';
import 'package:image_gallery/src/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageApi api;

  ImageRepositoryImpl(this.api);

  @override
  Future<List<ImageModel>> getImages(int page, {String? query}) async {
    return api.fetchImages(page, query: query);
  }
}
