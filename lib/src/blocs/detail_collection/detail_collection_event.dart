part of 'detail_collection_bloc.dart';

abstract class DetailCollectionEvent extends Equatable {
  const DetailCollectionEvent();

  @override
  List<Object> get props => [];
}

class GetPhotosFromCollection extends DetailCollectionEvent {
  final String collectionID;
  final int perPage;
  const GetPhotosFromCollection({required this.collectionID, required this.perPage});

  @override
  List<Object> get props => [collectionID, perPage];
}
