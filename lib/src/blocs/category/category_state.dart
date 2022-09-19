part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryChangeState extends CategoryState {
  final int index;
  const CategoryChangeState({this.index = 0});
  @override
  List<Object> get props => [index];
}
