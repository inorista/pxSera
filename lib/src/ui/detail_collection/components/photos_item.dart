import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
// ignore: unnecessary_import
import "package:flutter/material.dart";
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';
import 'package:pxsera/src/ui/zoomable/zoomable_photo_screen.dart';

class photos_item extends StatefulWidget {
  const photos_item({
    Key? key,
    required this.photo,
    required this.height,
  }) : super(key: key);

  final Photo photo;
  final double height;

  @override
  State<photos_item> createState() => _photos_itemState();
}

class _photos_itemState extends State<photos_item> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        SlideRoute(
            page: ZoomablePhotoScreen(
              photo: widget.photo,
            ),
            x: 1,
            y: 0),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.photo.urls.small,
        fit: BoxFit.cover,
        height: widget.height,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
