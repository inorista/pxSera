import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/src/blocs/category/category_bloc.dart';
import 'package:pxsera/src/blocs/dashboard/dash_board_bloc.dart';
import 'package:pxsera/src/blocs/detail_collection/detail_collection_bloc.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/blocs/home/photo_bloc.dart';
import 'package:pxsera/src/blocs/search/search_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/blocs/total_photo/total_photo_bloc.dart';
import 'package:pxsera/src/ui/dashboard/dashboard_screen.dart';

import 'src/blocs/setting/setting_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PhotoBloc()..add(const LoadApiEvent())),
        BlocProvider(create: (context) => DashBoardBloc()),
        BlocProvider(create: (context) => SettingBloc()),
        BlocProvider(create: (context) => DetailPhotoBloc()),
        BlocProvider(create: (context) => TotalPhotoBloc()),
        BlocProvider(create: (context) => DetailCollectionBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'pxSera',
            theme: state.themes,
            home: const DashBoardScreen(),
          );
        },
      ),
    );
  }
}
