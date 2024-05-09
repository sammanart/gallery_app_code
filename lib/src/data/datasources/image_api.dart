import 'package:dio/dio.dart';
import 'package:image_gallery/src/config/api_config.dart';
import 'package:image_gallery/src/config/endpoints.dart';
import '../models/image_model.dart';

class ImageApi {
  final Dio dio;

  ImageApi(this.dio);

  Future<List<ImageModel>> fetchImages(
    int page, {
    String? query,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.apiEndPoint,
        queryParameters: {
          'key': ApiConfig.apiKey,
          'page': page,
          'per_page': 50,
          'q': query,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return (data['hits'] as List)
            .map((e) => ImageModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: $e');
    }
  }
}
