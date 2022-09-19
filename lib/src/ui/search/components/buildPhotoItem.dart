import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pxsera/src/models/photo.dart';

class buildPhotoItem extends StatefulWidget {
  const buildPhotoItem({
    Key? key,
    required this.photo,
    required this.height,
    required this.press,
  }) : super(key: key);

  final Photo photo;
  final VoidCallback press;
  final double height;

  @override
  State<buildPhotoItem> createState() => _buildPhotoItemState();
}

class _buildPhotoItemState extends State<buildPhotoItem> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        height: widget.height,
        child: CachedNetworkImage(
          imageUrl: widget.photo.urls.small,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
