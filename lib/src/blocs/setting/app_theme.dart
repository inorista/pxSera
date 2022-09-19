import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pxsera/constants/style_constant.dart';

enum AppTheme {
  DarkTheme,
  NormalTheme,
}

final appThemeData = {
  AppTheme.NormalTheme: ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(),
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xff16141A),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    appBarTheme: AppBarTheme(
      elevation: 4,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 14,
        fontFamily: kTitleAppBar.fontFamily,
        color: const Color(0xff16141A),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white.withOpacity(0.80),
      unselectedItemColor: const Color(0xff828282),
      selectedItemColor: const Color(0xff16141A),
    ),
    fontFamily: "Montserrat",
    textTheme: TextTheme(
      bodyText1: const TextStyle(color: Color(0xff16141A)),
      bodyText2: GoogleFonts.montserrat(color: const Color(0xff16141A)),
    ),
    iconTheme: const IconThemeData(
      size: 25,
      color: Color(0xff16141A),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.DarkTheme: ThemeData(
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: const Color(0xff1e1e1e),
      titleTextStyle: TextStyle(
        fontSize: 14,
        fontFamily: kTitleAppBar.fontFamily,
        color: const Color(0xffffffff),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xff121212).withOpacity(0.85),
      unselectedItemColor: const Color(0xff5c5c5c),
      selectedItemColor: Colors.white,
    ),
    fontFamily: "Montserrat",
    textTheme: TextTheme(
      headline1: const TextStyle(),
      bodyText1: const TextStyle(
        color: Color(0xffffffff),
      ),
      bodyText2: GoogleFonts.montserrat(
        color: const Color(0xffffffff),
      ),
    ),
    iconTheme: const IconThemeData(
      size: 25,
      color: Color(0xffffffff),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff121212),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
};
