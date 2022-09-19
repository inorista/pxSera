import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pxsera/src/blocs/dashboard/dash_board_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_state.dart';
import 'package:pxsera/src/ui/home/home_screen.dart';
import 'package:pxsera/src/ui/search/search_screen.dart';
import 'package:pxsera/src/ui/setting/settings_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: IndexedStack(
            index: state.currentIndex,
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              SettingsScreen(),
            ],
          ),
          bottomNavigationBar: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, themeState) {
              return Container(
                height: 65,
                child: ClipRRect(
                  child: BlocBuilder<SettingBloc, SettingState>(
                    builder: (context, themeState) {
                      return Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          bottomNavigationBarTheme: themeState.themes.bottomNavigationBarTheme,
                        ),
                        child: BottomNavigationBar(
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          elevation: 0,
                          type: BottomNavigationBarType.fixed,
                          iconSize: 25,
                          selectedFontSize: 10,
                          unselectedFontSize: 10,
                          onTap: (index) => context.read<DashBoardBloc>().add(
                                ChangeIndexEvent(
                                  index: index,
                                ),
                              ),
                          currentIndex: state.currentIndex,
                          items: const [
                            BottomNavigationBarItem(
                              icon: Icon(Iconsax.home5),
                              label: "",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Iconsax.search_favorite_14),
                              label: "",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(EvaIcons.settings),
                              label: "",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
