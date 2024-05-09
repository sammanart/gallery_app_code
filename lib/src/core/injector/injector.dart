import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_gallery/src/config/api_config.dart';
import 'package:image_gallery/src/data/datasources/image_api.dart';
import 'package:image_gallery/src/data/repositories/image_repository.dart';
import 'package:image_gallery/src/domain/repositories/image_repository.dart';
import 'package:image_gallery/src/domain/use_cases/image_loader.dart';

final injector = GetIt.instance;

Future<void> call() async {
  injector.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
      ),
    ),
  );

  injector.registerSingleton<ImageApi>(
    ImageApi(injector<Dio>()),
  );

  injector.registerSingleton<ImageRepository>(
    ImageRepositoryImpl(injector<ImageApi>()),
  );

  injector.registerSingleton<ImageLoader>(
    ImageLoader(injector<ImageRepository>()),
  );
}
