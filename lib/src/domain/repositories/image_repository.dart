import 'package:image_gallery/src/data/models/image_model.dart';

abstract class ImageRepository {
  Future<List<ImageModel>> getImages(int page, {String? query});
}
