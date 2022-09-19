import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryChangeState()) {
    on<ChangedIndexCategory>((event, emit) {
      emit(CategoryChangeState(index: event.selectedIndex));
    });
  }
}
