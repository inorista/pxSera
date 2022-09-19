import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:pxsera/src/blocs/search/search_bloc.dart';
import 'package:pxsera/src/blocs/total_photo/total_photo_bloc.dart';
import 'package:pxsera/src/ui/detail_user/detail_user_screen.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';

class searchUserView extends StatefulWidget {
  const searchUserView({super.key});

  @override
  State<searchUserView> createState() => _searchUserViewState();
}

class _searchUserViewState extends State<searchUserView> {
  final currencyFormatter = NumberFormat('###,000', 'ID');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, searchState) {
        if (searchState is SearchedResult) {
          if (searchState.listSeachedPhotos.isEmpty) {
            return const Center(
              child: Text("Không có kết quả nào khớp với từ khóa."),
            );
          } else {
            final listSearchedUsers = searchState.listSearchedUsers;
            return ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: [
                searchState.usersResult == 0
                    ? Text(
                        "Không có kết quả với từ khóa bạn tìm",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        "Có khoảng ${currencyFormatter.format(searchState.usersResult)} kết quả khớp với từ khóa.",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ListView.builder(
                  padding: const EdgeInsets.only(top: 15),
                  addAutomaticKeepAlives: true,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listSearchedUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: listSearchedUsers[index].profileImage.medium,
                                fadeInDuration: const Duration(milliseconds: 100),
                                fadeOutDuration: const Duration(milliseconds: 100),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CupertinoActivityIndicator(),
                              ),
                            ),
                            Container(width: 10),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${listSearchedUsers[index].name}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(height: 5),
                                  Text("@${listSearchedUsers[index].username}"),
                                  Container(height: 5),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      onPrimary: Color(0xff242626).withOpacity(0.5),
                                      backgroundColor: Color(0xffe7e7e7),
                                      shadowColor: Colors.white,
                                      surfaceTintColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      context.read<TotalPhotoBloc>()
                                        ..add(
                                          LoadUserPhotos(
                                            userName: listSearchedUsers[index].username,
                                          ),
                                        );
                                      Navigator.push(
                                        context,
                                        SlideRoute(
                                          page: DetailUserScreen(user: listSearchedUsers[index]),
                                          x: 1,
                                          y: 0,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Xem profile",
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            color: Color(0xff242626),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
