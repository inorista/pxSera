import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pxsera/constants/style_constant.dart';
import 'package:pxsera/src/blocs/dashboard/dash_board_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_state.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/ui/home/components/masonry_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: NestedScrollView(
            floatHeaderSlivers: true,
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(FontAwesomeIcons.barsStaggered),
                      Container(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text("pixel", style: kBrandName2),
                          ),
                          BlocBuilder<SettingBloc, SettingState>(
                            builder: (context, state) {
                              return Text(
                                "Sera",
                                style: TextStyle(
                                  fontFamily: kBrandName1.fontFamily,
                                  fontSize: kBrandName1.fontSize,
                                  color: state.themes.textTheme.bodyText2!.color,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Container(height: 15),
                      GestureDetector(
                        onTap: () => context.read<DashBoardBloc>().add(ChangeIndexEvent(index: 1)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xfff3f3f5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tìm kiếm hình ảnh với từ khóa",
                                style: kTextField,
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0xff333367),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Icon(
                                    EvaIcons.search,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*TextFormField(
                        onTap: () {
                          print("TAPPED");
                          context.read<DashBoardBloc>().add(ChangeIndexEvent(index: 1));
                        },
                        on
                        maxLength: 22,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: const Color(0xff1a1add),
                        decoration: InputDecoration(
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xfff3f3f5),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                          isDense: true,
                          filled: true,
                          fillColor: const Color(0xfff3f2f7),
                          counterText: "",
                          hintText: "Tìm kiếm hình ảnh với từ khóa",
                          hintStyle: kTextField,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: const Color(0xff333367),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Icon(
                                  EvaIcons.search,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 25,
                            minHeight: 25,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xfff3f3f5),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xfff3f3f5),
                            ),
                          ),
                        ),
                      ),*/
                      Container(height: 25),
                    ],
                  ),
                ),
              ),
            ],
            body: const masonry_widget(),
          ),
        ),
      ),
    );
  }
}
