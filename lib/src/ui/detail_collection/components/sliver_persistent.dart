// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pxsera/src/models/collection.dart';

class HeaderPersistent extends SliverPersistentHeaderDelegate {
  double minimumExtent;
  double maximumExtent;
  final Color color;
  final Color titleColor;
  final Collection collection;

  HeaderPersistent({
    this.minimumExtent = 60,
    this.maximumExtent = 320,
    required this.color,
    required this.collection,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = (shrinkOffset / maximumExtent).clamp(0.1, 1);

    var opacity = ((minimumExtent / shrinkOffset / 2)) < 0.135 ? 0 : ((minimumExtent / shrinkOffset / 2)).clamp(0, 1);

    var opacityColor = (shrinkOffset / maximumExtent).toDouble() < 0.8
        ? 0
        : (shrinkOffset / maximumExtent).clamp(0.7, 1) > 0.85
            ? 1
            : (shrinkOffset / maximumExtent).clamp(0.7, 1);

    var opacityTitle =
        (shrinkOffset / maximumExtent).toDouble() < 0.75 ? 0 : (shrinkOffset / maximumExtent).clamp(0.75, 1);

    return SafeArea(
      child: Container(
        color: color.withOpacity(opacityColor.toDouble()),
        child: Stack(
          children: [
            Align(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 10),
                opacity: opacityTitle.toDouble(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Center(
                    child: Text(
                      "${collection.title}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AnimatedOpacity(
                  opacity: opacity.toDouble(),
                  duration: const Duration(milliseconds: 0),
                  child: Container(
                    height: maximumExtent * (1 - percent),
                    width: maximumExtent * (1 - percent),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 7,
                          blurRadius: 10,
                          offset: const Offset(4, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: collection.previewPhotos[0].urls.regular,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 10,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  EvaIcons.arrowIosBack,
                  size: 30,
                  color: titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maximumExtent;

  @override
  double get minExtent => minimumExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
