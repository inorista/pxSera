part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchedResult extends SearchState {
  final List<Photo> listSeachedPhotos;
  final List<User> listSearchedUsers;
  final List<Collection> listSearchedCollections;
  final int photosResult;
  final int usersResult;
  final int collectionsResult;
  const SearchedResult({
    required this.photosResult,
    required this.usersResult,
    required this.collectionsResult,
    this.listSeachedPhotos = const <Photo>[],
    this.listSearchedUsers = const <User>[],
    this.listSearchedCollections = const <Collection>[],
  });

  @override
  List<Object> get props => [
        listSeachedPhotos,
        listSearchedUsers,
        listSearchedCollections,
        photosResult,
        usersResult,
        collectionsResult,
      ];
}
