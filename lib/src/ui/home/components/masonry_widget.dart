import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pxsera/src/blocs/home/photo_bloc.dart';
import 'package:pxsera/src/models/models.dart';
import 'package:pxsera/src/ui/home/components/photo_widget.dart';

class masonry_widget extends StatefulWidget {
  const masonry_widget({
    Key? key,
  }) : super(key: key);

  @override
  State<masonry_widget> createState() => _masonry_widgetState();
}

class _masonry_widgetState extends State<masonry_widget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final rnd = Random();
    List<int> extents = List<int>.generate(10000, (int index) => rnd.nextInt(3) + 1);
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        if (state is PhotoLoading) {
          return const CupertinoActivityIndicator();
        } else if (state is PhotoLoaded) {
          return BlocListener<PhotoBloc, PhotoState>(
            listener: (context, state) {
              if (state is PhotoLoaded) {}
            },
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  bool isBottom = metrics.pixels == 0;

                  if (!isBottom) {
                    context.read<PhotoBloc>().add(const LoadMoreEvent());
                  }
                }
                return true;
              },
              child: RefreshIndicator(
                edgeOffset: 100,
                onRefresh: () async {
                  context.read<PhotoBloc>().add(const LoadApiEvent());
                },
                child: MasonryGridView.count(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  addAutomaticKeepAlives: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) {
                    List<Photo> listImage = state.listPhoto;
                    final height = (extents[index] + 0.5) * 100.toDouble();
                    return photo_widget(photo: listImage[index], height: height);
                  },
                  itemCount: state.listPhoto.length,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
