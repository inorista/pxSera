import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:pxsera/src/blocs/setting/app_theme.dart';
import 'package:pxsera/src/blocs/setting/setting_state.dart';
part 'setting_event.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState(themes: appThemeData[AppTheme.NormalTheme]!)) {
    on<ChangeThemeMode>((event, emit) {
      if (event.isDarkMode == true) {
        emit(SettingState(themes: appThemeData[AppTheme.DarkTheme]!));
      } else if (event.isDarkMode == false) {
        emit(SettingState(themes: appThemeData[AppTheme.NormalTheme]!));
      }
    });
  }
}
