part of 'detail_collection_bloc.dart';

abstract class DetailCollectionState extends Equatable {
  const DetailCollectionState();

  @override
  List<Object> get props => [];
}

class DetailCollectionLoading extends DetailCollectionState {}

class DetailCollectionLoaded extends DetailCollectionState {
  final List<Photo> collectionPhotos;
  const DetailCollectionLoaded({this.collectionPhotos = const <Photo>[]});
  @override
  List<Object> get props => [collectionPhotos];
}
