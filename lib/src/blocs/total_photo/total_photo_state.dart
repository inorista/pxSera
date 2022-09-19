part of 'total_photo_bloc.dart';

abstract class TotalPhotoState extends Equatable {
  const TotalPhotoState();

  @override
  List<Object> get props => [];
}

class TotalPhotoLoading extends TotalPhotoState {
  const TotalPhotoLoading();

  @override
  List<Object> get props => [];
}

class TotalPhotoLoaded extends TotalPhotoState {
  final List<Photo> photos;
  final List<Collection> collections;
  final List<Photo> liked_photos;
  const TotalPhotoLoaded({
    this.photos = const <Photo>[],
    this.collections = const <Collection>[],
    this.liked_photos = const <Photo>[],
  });

  @override
  List<Object> get props => [photos];
}
