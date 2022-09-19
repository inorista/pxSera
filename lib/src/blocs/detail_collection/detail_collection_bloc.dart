import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pxsera/src/resources/unsplash_api.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/network/dio_client.dart';

part 'detail_collection_event.dart';
part 'detail_collection_state.dart';

class DetailCollectionBloc extends Bloc<DetailCollectionEvent, DetailCollectionState> {
  final _dio = DioClient();
  DetailCollectionBloc() : super(DetailCollectionLoading()) {
    on<GetPhotosFromCollection>((event, emit) async {
      emit(DetailCollectionLoading());
      final _photoApi = PhotosApi(_dio);
      final collectionPhotos = await _photoApi.getCollectionPhotos(event.collectionID, perPage: event.perPage);
      emit(DetailCollectionLoaded(collectionPhotos: collectionPhotos));
    });
  }
}
