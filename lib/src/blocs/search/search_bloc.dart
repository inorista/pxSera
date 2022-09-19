import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/models/searched_photos.dart';
import 'package:pxsera/src/network/dio_client.dart';
import 'package:pxsera/src/resources/unsplash_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    final _dio = DioClient();
    final photoApi = PhotosApi(_dio);
    on<SearchWithQueryEvent>((event, emit) async {
      emit(SearchLoading());
      final searchedPhotos = await photoApi.searchPhotoByQuery(event.query);
      final searchedUsers = await photoApi.searchUserByQuery(event.query);
      final searchedCollections = await photoApi.searchCollectionByQuery(event.query);
      emit(
        SearchedResult(
          photosResult: searchedPhotos.total ?? 0,
          usersResult: searchedUsers.total ?? 0,
          collectionsResult: searchedCollections.total ?? 0,
          listSeachedPhotos: searchedPhotos.photos,
          listSearchedUsers: searchedUsers.users,
          listSearchedCollections: searchedCollections.collections,
        ),
      );
    });
  }
}
