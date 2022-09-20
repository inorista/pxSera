import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:pxsera/src/blocs/detail_collection/detail_collection_bloc.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/blocs/search/search_bloc.dart';
import 'package:pxsera/src/models/collection.dart';
import 'package:pxsera/src/ui/detail_collection/detail_collection_screen.dart';
import 'package:pxsera/src/ui/detail_photo/detail_photo_screen.dart';
import 'package:pxsera/src/ui/search/components/buildCollection.dart';
import 'package:pxsera/src/ui/search/components/buildPhotoItem.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';

class searchCollectionView extends StatefulWidget {
  const searchCollectionView({super.key});

  @override
  State<searchCollectionView> createState() => _searchCollectionViewState();
}

class _searchCollectionViewState extends State<searchCollectionView> with AutomaticKeepAliveClientMixin {
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
            final listSearchedCollections = searchState.listSearchedCollections;
            return ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: [
                Text(
                  "Có khoảng ${searchState.collectionsResult > 100 ? currencyFormatter.format(searchState.collectionsResult) : searchState.collectionsResult} kết quả khớp với từ khóa.",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listSearchedCollections.length,
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 14,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: [
                      const QuiltedGridTile(1, 1),
                      const QuiltedGridTile(1, 1),
                    ],
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return buildCollection(collection: listSearchedCollections[index]);
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
