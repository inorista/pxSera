import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_state.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:intl/intl.dart';
import 'package:pxsera/src/ui/detail_user/components/totalCollection_widget.dart';
import 'package:pxsera/src/ui/detail_user/components/totalPhoto_widget.dart';

class DetailUserScreen extends StatelessWidget {
  final User user;

  const DetailUserScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('###,000', 'ID');

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height),
          child: Container(
            height: double.infinity,
            child: NestedScrollView(
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(height: 50),
                            Container(
                              height: 80,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: user.profileImage.large,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const CupertinoActivityIndicator(),
                                ),
                              ),
                            ),
                            Container(height: 8),
                            Text("@${user.username}"),
                            Container(height: 8),
                            Text(
                              "${user.name}",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "${user.bio ?? "Người dùng chưa cập nhật bio."} ",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(height: 10),
                            const Divider(
                              thickness: 0.5,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 50,
                          left: 20,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              EvaIcons.arrowIosBack,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Theme(
                        data: ThemeData().copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: BlocBuilder<SettingBloc, SettingState>(
                          builder: (context, state) {
                            return TabBar(
                              indicatorPadding: EdgeInsets.zero,
                              padding: const EdgeInsets.only(bottom: 5),
                              indicatorColor: state.themes.textTheme.bodyText2!.color,
                              labelColor: state.themes.tabBarTheme.labelColor,
                              indicatorSize: state.themes.tabBarTheme.indicatorSize,
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              tabs: [
                                Tab(text: "Ảnh (${user.totalPhotos})"),
                                Tab(text: "Bộ Sưu Tập (${user.totalCollections})"),
                                Tab(text: "Đã Thích (${user.totalLikes})"),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          totalPhoto(tabKey: "totalPhoto"),
                          totalCollection(tabKey: "totalCollection"),
                          Text("OK3"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class buildInfo extends StatelessWidget {
  final String numberTitle;
  final String categoryTitle;
  const buildInfo({
    required this.numberTitle,
    required this.categoryTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${numberTitle}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(height: 3),
        Text(
          "${categoryTitle}",
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
