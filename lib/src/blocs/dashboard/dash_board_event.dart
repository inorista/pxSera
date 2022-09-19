part of 'dash_board_bloc.dart';

abstract class DashBoardEvent extends Equatable {
  const DashBoardEvent();

  @override
  List<Object> get props => [];
}

class ChangeIndexEvent extends DashBoardEvent {
  int index;
  ChangeIndexEvent({required this.index});
  @override
  List<Object> get props => [index];
}
