import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/blocs/setting/app_theme.dart';
import 'package:pxsera/src/blocs/setting/setting_bloc.dart';
import 'package:pxsera/src/blocs/setting/setting_state.dart';
import 'package:pxsera/src/blocs/total_photo/total_photo_bloc.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:intl/intl.dart';
import 'package:pxsera/src/network/launch_webview.dart';
import 'package:pxsera/src/ui/detail_user/detail_user_screen.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';
import 'package:pxsera/src/ui/zoomable/zoomable_photo_screen.dart';

class DetailPhotoScreen extends StatefulWidget {
  const DetailPhotoScreen({required this.photo, super.key});
  final Photo photo;

  @override
  State<DetailPhotoScreen> createState() => _DetailPhotoScreenState();
}

class _DetailPhotoScreenState extends State<DetailPhotoScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final isPhotoPortrait = (widget.photo.height / widget.photo.width) >= 1 ? true : false;
    final currencyFormatter = NumberFormat('###,000', 'ID');
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<DetailPhotoBloc, DetailPhotoState>(
        builder: (context, state) {
          if (state is DetailPhotoLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is DetailPhotoLoaded) {
            final exif = state.photo.exif;
            final user = state.photo.user;
            final photo = state.photo;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  toolbarHeight: 85,
                  automaticallyImplyLeading: true,
                  leading: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      context.read<DetailPhotoBloc>().add(ClearPhotoEvent());
                    },
                    child: const Icon(
                      EvaIcons.arrowIosBack,
                      size: 30,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  expandedHeight: isPhotoPortrait ? 550 : 300,
                  flexibleSpace: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          page: ZoomablePhotoScreen(photo: photo),
                          x: 0,
                          y: 1,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      child: Stack(
                        children: [
                          FlexibleSpaceBar(
                            background: CachedNetworkImage(
                              imageUrl: photo.urls.regular,
                              fadeInDuration: const Duration(milliseconds: 100),
                              fadeOutDuration: const Duration(milliseconds: 100),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CupertinoActivityIndicator(),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 14,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Nhấn vào ảnh để xem đầy đủ.",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff25254b),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildInfo(
                              state,
                              Iconsax.lovely5,
                              photo.likes < 100
                                  ? photo.likes.toString()
                                  : currencyFormatter.format(photo.likes).toString(),
                              const Color(0xffffa3ba),
                            ),
                            buildInfo(
                              state,
                              EvaIcons.download,
                              photo.downloads < 100
                                  ? photo.downloads.toString()
                                  : currencyFormatter.format(photo.downloads).toString(),
                              const Color(0xff74dac5),
                            ),
                            buildInfo(
                              state,
                              EvaIcons.eye,
                              photo.views < 100
                                  ? photo.views.toString()
                                  : currencyFormatter.format(photo.views).toString(),
                              Colors.grey,
                            ),
                          ],
                        ),
                        buildDivider(),
                        Text.rich(
                          TextSpan(
                            text: '${DateFormat('dd').format(DateTime.parse(photo.createdAt).toLocal())}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: ' tháng ',
                              ),

                              TextSpan(
                                text: '${DateFormat('MM, yyyy').format(DateTime.parse(photo.createdAt).toLocal())}',
                              ),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                        Container(height: 5),
                        Text.rich(
                          TextSpan(
                            text: 'Photo by ',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${photo.user.name}',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUserPage(photo.user.username);
                                  },
                              ),
                              const TextSpan(
                                text: ' on ',
                              ),
                              TextSpan(
                                text: 'Unsplash',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
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
                        Container(height: 12),
                        Text(
                          "Dimensions ${photo.width} x ${photo.height}",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Container(height: 4),
                        if (photo.exif?.model != null) ...[
                          Row(
                            children: [
                              Text(
                                "${photo.exif?.make?.toUpperCase() ?? ""} ${photo.exif?.model} ",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              if (photo.exif?.focalLength != null && photo.exif?.aperture != null) ...[
                                Text(
                                  "- ${photo.exif?.focalLength}mm f/${photo.exif?.aperture}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ]
                            ],
                          ),
                          Container(height: 4),
                          Text(
                            "ISO ${photo.exif?.isoSpeedEatings} - ${photo.exif?.exposureTime}s",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ] else ...[
                          const Text(
                            "Không có thông tin chi tiết của ảnh.",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                        Container(height: 30),
                        Text(
                          "${photo.description ?? "Tác giả chưa đặt mô tả cho ảnh!"}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Container(height: 20),
                        BlocBuilder<TotalPhotoBloc, TotalPhotoState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context.read<TotalPhotoBloc>()
                                  ..add(
                                    LoadUserPhotos(
                                      userName: photo.user.username,
                                    ),
                                  );
                                Navigator.push(
                                  context,
                                  SlideRoute(
                                    page: DetailUserScreen(user: photo.user),
                                    x: 1,
                                    y: 0,
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: photo.user.profileImage.medium.toString(),
                                          fit: BoxFit.fitWidth,
                                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                                        ),
                                      ),
                                    ),
                                    Container(width: 8),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${photo.user.username.toString()}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(height: 4),
                                            Text(
                                              "${photo.user.bio?.replaceAll("\n", "") ?? "Người dùng chưa cập nhật bio."}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: Text("LỖI"),
          );
        },
      ),
    );
  }

  BlocBuilder<SettingBloc, SettingState> buildDivider() {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Divider(
          thickness: 0.1,
          height: 20,
          color: state.themes == appThemeData[AppTheme.NormalTheme] ? const Color(0xff333367) : Colors.white,
        );
      },
    );
  }

  Row buildInfo(DetailPhotoLoaded state, IconData icon, String? info, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: color,
        ),
        Container(width: 12),
        Text(
          "${info ?? "0"}",
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
