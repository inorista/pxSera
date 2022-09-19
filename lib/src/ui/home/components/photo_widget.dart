import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/ui/detail_photo/detail_photo_screen.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';

class photo_widget extends StatefulWidget {
  const photo_widget({
    Key? key,
    required this.photo,
    required this.height,
  }) : super(key: key);

  final Photo photo;
  final double height;

  @override
  State<photo_widget> createState() => _photo_widgetState();
}

class _photo_widgetState extends State<photo_widget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPhotoBloc, DetailPhotoState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<DetailPhotoBloc>().add(GetPhotoEvent(photo: widget.photo));
            Navigator.push(
              context,
              SlideRoute(
                x: 1,
                y: 0,
                page: DetailPhotoScreen(
                  photo: widget.photo,
                ),
              ),
            );
          },
          child: SizedBox(
            height: widget.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.photo.urls.small,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f2f3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
