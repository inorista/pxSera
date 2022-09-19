import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pxsera/src/resources/unsplash_api.dart';
import 'package:pxsera/src/models/photo.dart';
import 'package:pxsera/src/network/dio_client.dart';
import 'package:pxsera/src/repositories/photos_repository.dart';
part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  int _currentPage = 1;
  final PhotosRepository _photoRespository = PhotosRepository();
  final _dio = DioClient();
  PhotoBloc() : super(PhotoLoading()) {
    on<LoadApiEvent>(onLoadPhotos);
    on<LoadMoreEvent>(onLoadMorePhotos);
  }
  void onLoadPhotos(LoadApiEvent event, Emitter<PhotoState> emit) async {
    emit(PhotoLoading());
    final photos = await _photoRespository.fetchPhotoList();
    emit(PhotoLoaded(listPhoto: photos));
  }

  void onLoadMorePhotos(LoadMoreEvent event, Emitter<PhotoState> emit) async {
    final state = this.state;

    final PhotosApi photoApi = PhotosApi(_dio);
    if (state is PhotoLoaded) {
      try {
        _currentPage += 1;
        final photos = await photoApi.getPhotos(page: _currentPage);

        emit(
          PhotoLoaded(
            listPhoto: List.from(state.listPhoto)..addAll(photos),
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }
}
