import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/blocs/total_photo/total_photo_bloc.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';
import 'package:pxsera/src/ui/zoomable/zoomable_photo_screen.dart';

class totalPhoto extends StatelessWidget {
  final String tabKey;
  const totalPhoto({Key? key, required this.tabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalPhotoBloc, TotalPhotoState>(
      builder: (context, state) {
        if (state is TotalPhotoLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is TotalPhotoLoaded) {
          final listUserPhoto = state.photos;
          return GridView.builder(
            key: PageStorageKey(tabKey),
            addAutomaticKeepAlives: true,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: listUserPhoto.length,
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(2, 2),
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(1, 1),
              ],
            ),
            itemBuilder: (BuildContext context, int index) {
              return BlocBuilder<DetailPhotoBloc, DetailPhotoState>(
                builder: (context, detailState) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRoute(page: ZoomablePhotoScreen(photo: listUserPhoto[index]), x: 1, y: 0),
                      );
                    },
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: listUserPhoto[index].urls.small,
                        fit: BoxFit.cover,
                        fadeOutDuration: const Duration(milliseconds: 100),
                        placeholderFadeInDuration: const Duration(milliseconds: 100),
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return const CupertinoActivityIndicator();
      },
    );
  }
}
