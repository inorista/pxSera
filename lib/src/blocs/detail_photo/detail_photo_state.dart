part of 'detail_photo_bloc.dart';

abstract class DetailPhotoState extends Equatable {
  const DetailPhotoState();

  @override
  List<Object> get props => [];
}

class DetailPhotoLoading extends DetailPhotoState {
  @override
  List<Object> get props => [];
}

class DetailPhotoLoaded extends DetailPhotoState {
  final Photo photo;
  const DetailPhotoLoaded({required this.photo});

  @override
  List<Object> get props => [photo];
}
