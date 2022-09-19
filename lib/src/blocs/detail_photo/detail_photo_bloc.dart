import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pxsera/src/resources/unsplash_api.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/network/dio_client.dart';
part 'detail_photo_event.dart';
part 'detail_photo_state.dart';

class DetailPhotoBloc extends Bloc<DetailPhotoEvent, DetailPhotoState> {
  final _dio = DioClient();

  DetailPhotoBloc() : super(DetailPhotoLoading()) {
    on<GetPhotoEvent>((event, emit) async {
      final _photoApi = PhotosApi(_dio);
      final infoPhoto = await _photoApi.getPhotoByID(event.photo.id);

      emit(DetailPhotoLoaded(photo: infoPhoto));
    });
    on<SavePhotoEvent>((event, emit) async {
      final photo = event.photo;
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/${photo.id}.jpg';
      await Dio().download(photo.urls.raw, path);
      await GallerySaver.saveImage(path);
    });
    on<ClearPhotoEvent>((event, emit) async {
      emit(DetailPhotoLoading());
    });
  }
}
