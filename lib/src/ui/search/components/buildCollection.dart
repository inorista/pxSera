import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/src/blocs/detail_collection/detail_collection_bloc.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/ui/detail_collection/detail_collection_screen.dart';
import 'package:pxsera/src/ui/widgets/page_transition.dart';

class buildCollection extends StatefulWidget {
  const buildCollection({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Collection collection;

  @override
  State<buildCollection> createState() => _buildCollectionState();
}

class _buildCollectionState extends State<buildCollection> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.collection.previewPhotos.isEmpty
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
                            collectionID: widget.collection.id,
                            perPage: widget.collection.totalPhotos,
                          ),
                        );
                    Navigator.push(
                      context,
                      SlideRoute(page: DetailCollectionScreen(collection: widget.collection), x: 1, y: 0),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.collection.previewPhotos[0].urls.small,
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
          "${widget.collection.title}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${widget.collection.totalPhotos} mục",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 82, 81, 83),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
