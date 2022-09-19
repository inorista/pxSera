part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeMode extends SettingEvent {
  bool isDarkMode;
  ChangeThemeMode({required this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}
