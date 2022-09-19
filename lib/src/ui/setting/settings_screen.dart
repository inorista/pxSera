import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/constants/style_constant.dart';
import 'package:pxsera/src/blocs/setting/app_theme.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 55,
        title: Text(
          "Cài Đặt",
          style: TextStyle(
            fontFamily: kTitleAppBar.fontFamily,
            fontSize: kTitleAppBar.fontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Chế độ tối"),
                        SizedBox(
                          width: 50,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Switch.adaptive(
                                value: state.themes == appThemeData[AppTheme.NormalTheme] ? false : true,
                                onChanged: (bool boolTheme) {
                                  context.read<SettingBloc>().add(ChangeThemeMode(isDarkMode: boolTheme));
                                },
                              )

                              /*LiteRollingSwitch(
                              width: 90,
                              animationDuration: const Duration(milliseconds: 100),
                              value: state.themes == appThemeData[AppTheme.NormalTheme] ? false : true,
                              textOn: '',
                              textOff: '',
                              colorOn: Colors.green,
                              colorOff: const Color(0xff656565),
                              iconOn: EvaIcons.moon,
                              iconOff: EvaIcons.sun,
                              textSize: 16.0,
                              onChanged: (bool boolTheme) {
                                context.read<ThemeBloc>().add(ChangeThemeMode(isDarkMode: boolTheme));
                              },
                              onDoubleTap: () {},
                              onSwipe: () {},
                              onTap: () {},
                            ),*/
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
