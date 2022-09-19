import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/models/models.dart';

class ZoomablePhotoScreen extends StatefulWidget {
  const ZoomablePhotoScreen({required this.photo, super.key});
  final Photo photo;

  @override
  State<ZoomablePhotoScreen> createState() => _ZoomablePhotoScreenState();
}

class _ZoomablePhotoScreenState extends State<ZoomablePhotoScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff171312),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InteractiveViewer(
                minScale: 2,
                maxScale: 10,
                child: CachedNetworkImage(
                  imageUrl: widget.photo.urls.regular,
                  fit: BoxFit.fill,
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
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      EvaIcons.arrowIosBack,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 2,
                                    sigmaY: 2,
                                  ),
                                  child: buildEleButton(
                                    press: () {
                                      context.read<DetailPhotoBloc>().add(SavePhotoEvent(photo: widget.photo));
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text("Đã lưu ảnh"),
                                        ),
                                      );
                                    },
                                    title: 'Lưu ảnh',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              buildEleButton(
                                title: "Hủy",
                                press: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      EvaIcons.moreHorizontal,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class buildEleButton extends StatelessWidget {
  final VoidCallback press;
  final String title;
  const buildEleButton({
    required this.title,
    required this.press,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(0.4),
        onPrimary: Colors.red.withOpacity(0.02),
      ),
      onPressed: press,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            "${title}",
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

class buildButton extends StatelessWidget {
  final VoidCallback press;
  final String title;
  const buildButton({
    Key? key,
    required this.press,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.grey.withOpacity(0.4),
          ),
          child: Text(
            "${title}",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
