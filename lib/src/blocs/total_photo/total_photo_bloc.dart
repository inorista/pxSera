import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pxsera/src/resources/unsplash_api.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/network/dio_client.dart';

part 'total_photo_event.dart';
part 'total_photo_state.dart';

class TotalPhotoBloc extends Bloc<TotalPhotoEvent, TotalPhotoState> {
  int _currentPage = 1;
  final _dio = DioClient();
  TotalPhotoBloc() : super(const TotalPhotoLoading()) {
    on<LoadUserPhotos>((event, emit) async {
      emit(const TotalPhotoLoading());
      final _photosApi = PhotosApi(_dio);
      final photos = await _photosApi.getUserPhotos(event.userName);
      final collections = await _photosApi.getUserCollections(event.userName);
      final liked_photos = await _photosApi.getUserLikedPhotos(event.userName);
      emit(
        TotalPhotoLoaded(
          photos: photos,
          collections: collections,
          liked_photos: liked_photos,
        ),
      );
    });
  }
}
