import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/models/searched_photos.dart';
import 'package:pxsera/src/models/searched_users.dart';
import 'package:pxsera/src/network/dio_client.dart';
import 'package:pxsera/src/models/searched_collections.dart';

class PhotosApi {
  PhotosApi(this._DioClient);
  final DioClient _DioClient;

  @override
  Future<List<Photo>> getPhotos({
    int page = 1,
    int perPage = 30,
    String orderBy = "lastest",
  }) async {
    final photos = await _DioClient.get('/photos', queryParameters: {
      "page": page,
      "per_page": perPage,
      "order_by": orderBy,
    });
    return (photos as List).map((elm) => Photo.fromMap(elm)).toList();
  }

  Future<Photo> getPhotoByID(String idPhoto) async {
    final photo = await _DioClient.get('/photos/$idPhoto', queryParameters: {
      "id": idPhoto,
    });
    return Photo.fromMap(photo);
  }

  Future<List<Photo>> getUserPhotos(
    String userName, {
    int page = 1,
    int perPage = 100,
  }) async {
    final photos = await _DioClient.get('/users/$userName/photos', queryParameters: {
      "username": userName,
      "page": page,
      "per_page": perPage,
    });
    return (photos as List).map((elm) => Photo.fromMap(elm)).toList();
  }

  Future<List<Collection>> getUserCollections(
    String userName, {
    int page = 1,
    int perPage = 100,
  }) async {
    final collections = await _DioClient.get('/users/$userName/collections', queryParameters: {
      "username": userName,
      "page": page,
      "per_page": perPage,
    });
    return (collections as List).map((collection) => Collection.fromMap(collection)).toList();
  }

  Future<List<Photo>> getUserLikedPhotos(
    String userName, {
    int page = 1,
    int perPage = 100,
  }) async {
    final collections = await _DioClient.get('/users/$userName/likes', queryParameters: {
      "username": userName,
      "page": page,
      "per_page": perPage,
    });
    return (collections as List).map((collection) => Photo.fromMap(collection)).toList();
  }

  Future<List<Photo>> getCollectionPhotos(
    String collectionID, {
    int page = 1,
    int perPage = 100,
  }) async {
    final collectionPhotos = await _DioClient.get('/collections/$collectionID/photos', queryParameters: {
      "id": collectionID,
      "page": page,
      "per_page": perPage,
    });

    return (collectionPhotos as List).map((elm) => Photo.fromMap(elm)).toList();
  }

  Future<searched_photos> searchPhotoByQuery(String searchQuery, {int page = 1, int perPage = 100}) async {
    final photosSearched = await _DioClient.get('/search/photos', queryParameters: {
      "query": searchQuery,
      "page": page,
      "per_page": perPage,
    });

    return searched_photos.fromJson(photosSearched);
  }

  Future<searched_collections> searchCollectionByQuery(String searchQuery, {int page = 1, int perPage = 100}) async {
    final collectionsSearched = await _DioClient.get('/search/collections', queryParameters: {
      "query": searchQuery,
      "page": page,
      "per_page": perPage,
    });

    return searched_collections.fromJson(collectionsSearched);
  }

  Future<searched_users> searchUserByQuery(String searchQuery, {int page = 1, int perPage = 100}) async {
    final usersSearched = await _DioClient.get('/search/users', queryParameters: {
      "query": searchQuery,
      "page": page,
      "per_page": perPage,
    });

    return searched_users.fromJson(usersSearched);
  }
}
