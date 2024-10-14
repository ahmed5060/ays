import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';
import '../../providers/videos_provider.dart';
import '../playlist/playlist_screen.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}
  class _VideosScreenState extends State<VideosScreen> {


  @override
  void initState() {
    super.initState();
   
    Future.delayed(Duration.zero, () async {
      await Provider.of<VideosProvider>(
        context,
        listen: false,
      ).getSections(
        content: true,
        sectionId: widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideosProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: const MainAppBarWidget(
          title: 'Videos',
        ),
        body: provider.videos.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: Platform.isWindows ? 50 : 20,
                  vertical: Platform.isWindows ? 30 : 15,
                ),
                itemBuilder: (ctx, index) => SharedItemWidget(
                  model: NavigationModel(
                      name: provider.videos[index].name,
                      image: AppImages.play,
                      index: index,
                      onTap: () {
                        context.push(
                          PlaylistScreen(
                            index: index,
                          ),
                        );
                      }),
                ),
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 25,
                ),
                itemCount: provider.videos.length,
              )
            : Center(
                child: provider.getVideosLoading
                    ? const LoadingWidget()
                    : const EmptyWidget(),
              ),
      );
    });
  }
}
