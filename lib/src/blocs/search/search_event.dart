part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchWithQueryEvent extends SearchEvent {
  final String query;
  const SearchWithQueryEvent({required this.query});

  @override
  List<Object> get props => [query];
}
