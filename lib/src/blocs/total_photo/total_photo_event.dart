part of 'total_photo_bloc.dart';

abstract class TotalPhotoEvent extends Equatable {
  const TotalPhotoEvent();

  @override
  List<Object> get props => [];
}

class LoadUserPhotos extends TotalPhotoEvent {
  final String userName;
  const LoadUserPhotos({required this.userName});

  @override
  List<Object> get props => [userName];
}

class LoadMoreUserPhotos extends TotalPhotoEvent {
  const LoadMoreUserPhotos();

  @override
  List<Object> get props => [];
}

class LoadMoreUserCollections extends TotalPhotoEvent {
  const LoadMoreUserCollections();

  @override
  List<Object> get props => [];
}

class LoadMoreUserLikedPhotos extends TotalPhotoEvent {
  const LoadMoreUserLikedPhotos();
  @override
  List<Object> get props => [];
}
