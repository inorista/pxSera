import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/blocs/search/search_bloc.dart';
import 'package:pxsera/src/models/photo.dart';
import 'package:pxsera/src/ui/detail_photo/detail_photo_screen.dart';
import 'package:pxsera/src/ui/search/components/buildPhotoItem.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';
import 'package:intl/intl.dart';

class searchPhotoView extends StatefulWidget {
  const searchPhotoView({super.key});

  @override
  State<searchPhotoView> createState() => _searchPhotoViewState();
}

class _searchPhotoViewState extends State<searchPhotoView> with AutomaticKeepAliveClientMixin {
  final currencyFormatter = NumberFormat('###,000', 'ID');
  @override
  Widget build(BuildContext context) {
    final rnd = Random();
    List<int> extents = List<int>.generate(10000, (int index) => rnd.nextInt(2) + 1);

    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, searchState) {
        if (searchState is SearchedResult) {
          if (searchState.listSeachedPhotos.isEmpty) {
            return const Center(
              child: Text("Không có kết quả nào khớp với từ khóa."),
            );
          } else {
            final listSearchedPhotos = searchState.listSeachedPhotos;
            return ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: [
                Text(
                  "Có khoảng ${searchState.photosResult > 100 ? currencyFormatter.format(searchState.photosResult) : searchState.photosResult} kết quả khớp với từ khóa.",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                MasonryGridView.count(
                  padding: const EdgeInsets.only(top: 15),
                  addAutomaticKeepAlives: true,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listSearchedPhotos.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (BuildContext context, int index) {
                    final height = (extents[index] + 0.5) * 100.toDouble();
                    return buildPhotoItem(
                      height: height,
                      photo: listSearchedPhotos[index],
                      press: () {
                        context.read<DetailPhotoBloc>().add(GetPhotoEvent(photo: listSearchedPhotos[index]));
                        Navigator.push(
                          context,
                          SlideRoute(
                            x: 1,
                            y: 0,
                            page: DetailPhotoScreen(
                              photo: listSearchedPhotos[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
        } else if (searchState is SearchLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
