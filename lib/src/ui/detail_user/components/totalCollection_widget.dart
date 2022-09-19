import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pxsera/src/blocs/detail_collection/detail_collection_bloc.dart';
import 'package:pxsera/src/blocs/detail_photo/detail_photo_bloc.dart';
import 'package:pxsera/src/blocs/total_photo/total_photo_bloc.dart';
import 'package:pxsera/src/ui/detail_collection/detail_collection_screen.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';

class totalCollection extends StatelessWidget {
  final String tabKey;
  const totalCollection({
    required this.tabKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalPhotoBloc, TotalPhotoState>(
      builder: (context, state) {
        if (state is TotalPhotoLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is TotalPhotoLoaded) {
          final listUserCollection = state.collections;
          if (listUserCollection.length == 0) {
            return const Center(
              child: Text("Không có bộ sưu tập nào để hiển thị."),
            );
          }
          return BlocBuilder<DetailPhotoBloc, DetailPhotoState>(
            builder: (context, detailState) {
              return BlocBuilder<DetailCollectionBloc, DetailCollectionState>(
                builder: (context, detailCollectionState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: GridView.builder(
                      key: PageStorageKey(tabKey),
                      addAutomaticKeepAlives: true,
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: listUserCollection.length,
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            listUserCollection[index].previewPhotos.isEmpty
                                ? Flexible(
                                    child: Container(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.width / 2,
                                      color: const Color(0xffF5F5F5),
                                    ),
                                  )
                                : Flexible(
                                    child: GestureDetector(
                                      onTap: () async {
                                        context.read<DetailCollectionBloc>().add(
                                              GetPhotosFromCollection(
                                                collectionID: listUserCollection[index].id,
                                                perPage: listUserCollection[index].totalPhotos,
                                              ),
                                            );
                                        Navigator.push(
                                          context,
                                          SlideRoute(
                                              page: DetailCollectionScreen(collection: listUserCollection[index]),
                                              x: 1,
                                              y: 0),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: listUserCollection[index].previewPhotos[0].urls.regular,
                                        fit: BoxFit.cover,
                                        height: MediaQuery.of(context).size.width / 2,
                                        width: double.infinity,
                                        fadeOutDuration: const Duration(milliseconds: 100),
                                        placeholderFadeInDuration: const Duration(milliseconds: 100),
                                        placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                            Text(
                              "${listUserCollection[index].title}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${listUserCollection[index].totalPhotos} mục",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 82, 81, 83),
                              ),
                            ),
                          ],
                        );
                      },
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
