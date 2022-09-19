part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class LoadApiEvent extends PhotoEvent {
  final List<Photo> photos;
  const LoadApiEvent({this.photos = const <Photo>[]});
  @override
  List<Object> get props => [photos];
}

class LoadMoreEvent extends PhotoEvent {
  const LoadMoreEvent();
  @override
  List<Object> get props => [];
}
