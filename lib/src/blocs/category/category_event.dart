part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ChangedIndexCategory extends CategoryEvent {
  final int selectedIndex;
  const ChangedIndexCategory({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
