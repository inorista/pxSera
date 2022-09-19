import 'package:pxsera/src/resources/unsplash_api.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/network/dio_client.dart';

class PhotosRepository {
  final _dio = DioClient();
  final PhotosApi _photosApiProvider = PhotosApi(DioClient());

  Future<List<Photo>> fetchPhotoList() {
    return _photosApiProvider.getPhotos();
  }
}

class NetworkError extends Error {}
