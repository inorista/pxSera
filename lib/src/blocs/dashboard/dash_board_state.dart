part of 'dash_board_bloc.dart';

class DashBoardState extends Equatable {
  const DashBoardState({this.currentIndex = 0});
  final int currentIndex;

  @override
  List<Object> get props => [currentIndex];
}
