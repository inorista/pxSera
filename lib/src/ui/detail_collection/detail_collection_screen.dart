import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pxsera/src/blocs/detail_collection/detail_collection_bloc.dart';
import 'package:pxsera/src/models/collection.dart';
import 'package:pxsera/src/network/launch_webview.dart';
import 'package:pxsera/src/ui/detail_collection/components/photos_item.dart';
import 'package:pxsera/src/ui/detail_collection/components/sliver_persistent.dart';
import 'package:intl/intl.dart';

extension ColorExtension on String {
  toColor(String opacity) {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "${opacity}" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class DetailCollectionScreen extends StatelessWidget {
  final Collection collection;

  DetailCollectionScreen({
    required this.collection,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mainColorBackground = collection.coverPhoto!.color.toColor("FF");
    final grayscale =
        (0.299 * mainColorBackground.red) + (0.587 * mainColorBackground.green) + (0.114 * mainColorBackground.blue);
    final rnd = Random();
    final Color textMainColor = grayscale > 167 ? const Color(0xff16141A) : Colors.white;
    List<int> extents = List<int>.generate(10000, (int index) => rnd.nextInt(2) + 1);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                collection.coverPhoto?.color.toColor("FF"),
                collection.coverPhoto?.color.toColor("CC"),
                collection.coverPhoto?.color.toColor("4D"),
                collection.coverPhoto?.color.toColor("33"),
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: HeaderPersistent(
                  color: collection.coverPhoto?.color.toColor("FF"),
                  collection: collection,
                  titleColor: textMainColor,
                ),
              ),
              /*SliverAppBar(
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    EvaIcons.arrowIosBack,
                    size: 30,
                  ),
                ),
                stretch: true,
                pinned: true,
                elevation: 0,
                expandedHeight: 300,
                backgroundColor: collection.coverPhoto?.color.toColor("FF").withOpacity(0.5),
                flexibleSpace: SafeArea(
                  child: FlexibleSpaceBar(
                    stretchModes: [StretchMode.zoomBackground],
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: collection.previewPhotos[0].urls.regular,
                          fit: BoxFit.fitHeight,
                          width: MediaQuery.of(context).size.width / 1.3,
                          fadeOutDuration: const Duration(milliseconds: 100),
                          placeholderFadeInDuration: const Duration(milliseconds: 100),
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                              "assets/images/loading.gif",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${collection.title}",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: textMainColor,
                        ),
                      ),
                      Container(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: collection.user.profileImage.small,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          Container(width: 8),
                          Text(
                            "${collection.user.username}",
                            style: TextStyle(
                              color: textMainColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 5),
                      Row(
                        children: [
                          Text(
                            "${DateFormat('dd').format(DateTime.parse(collection.publishedAt).toLocal())}",
                            style: TextStyle(
                              fontSize: 13,
                              color: textMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " tháng ",
                            style: TextStyle(
                              fontSize: 13,
                              color: textMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${DateFormat('MM, yyyy').format(DateTime.parse(collection.publishedAt).toLocal())}",
                            style: TextStyle(
                              fontSize: 13,
                              color: textMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " • ",
                            style: TextStyle(
                              fontSize: 16,
                              color: textMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${collection.totalPhotos} bức ảnh",
                            style: TextStyle(
                              fontSize: 13,
                              color: textMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Container(height: 5),
                      Text.rich(
                        TextSpan(
                          text: 'Collection by ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textMainColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${collection.user.name}',
                              style: const TextStyle(decoration: TextDecoration.underline, fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUserPage(collection.user.username);
                                },
                            ),
                            const TextSpan(
                              text: ' on ',
                            ),
                            TextSpan(
                              text: 'Unsplash',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUnsplashHome();
                                },
                            ),
                            // can add more TextSpans here...
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: BlocBuilder<DetailCollectionBloc, DetailCollectionState>(
                      builder: (context, detailCollectionState) {
                        if (detailCollectionState is DetailCollectionLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        if (detailCollectionState is DetailCollectionLoaded) {
                          detailCollectionState.collectionPhotos.shuffle();
                          final listCollectionPhotos = detailCollectionState.collectionPhotos;
                          return MasonryGridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listCollectionPhotos.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            itemBuilder: (BuildContext context, int index) {
                              final height = (extents[index] + 0.5) * 100.toDouble();
                              return photos_item(photo: listCollectionPhotos[index], height: height);
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
