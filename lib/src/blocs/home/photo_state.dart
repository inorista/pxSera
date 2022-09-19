part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoLoading extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoaded extends PhotoState {
  final List<Photo> listPhoto;
  const PhotoLoaded({this.listPhoto = const <Photo>[]});
  @override
  List<Object> get props => [listPhoto];
}

class PhotoFailure extends PhotoState {
  final String? message;
  const PhotoFailure(this.message);
}

class PhotoLoadedOne extends PhotoState {
  final Photo photo;
  const PhotoLoadedOne({required this.photo});
  @override
  List<Object> get props => [photo];
}
