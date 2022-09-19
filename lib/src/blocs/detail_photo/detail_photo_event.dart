part of 'detail_photo_bloc.dart';

abstract class DetailPhotoEvent extends Equatable {
  const DetailPhotoEvent();

  @override
  List<Object> get props => [];
}

class GetPhotoEvent extends DetailPhotoEvent {
  final Photo photo;
  const GetPhotoEvent({required this.photo});

  @override
  List<Object> get props => [photo];
}

class SavePhotoEvent extends DetailPhotoEvent {
  final Photo photo;
  const SavePhotoEvent({required this.photo});
  @override
  List<Object> get props => [photo];
}

class ClearPhotoEvent extends DetailPhotoEvent {
  @override
  List<Object> get props => [];
}
