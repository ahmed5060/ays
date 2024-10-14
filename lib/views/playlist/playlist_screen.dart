import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/videos_provider.dart';
import 'package:courses_app/views/playlist/videoShow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState

    //   _controller = VideoPlayerController.network(
    //   'https://www.example.com/sample.mp4',
    // )..initialize().then((_) {
    //   // Ensure the first frame is shown after the video is initialized
    //   setState(() {});
    // });
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<VideosProvider>(
        context,
        listen: false,
      ).changePlayerCurrentIndex(
        widget.index,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Consumer<VideosProvider>(builder: (context, provider, _) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Platform.isWindows ? 50 : 10,
            vertical: Platform.isWindows ? 30 : 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                height: Platform.isWindows
                    ? 40.appHeight(context)
                    : MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 100.appHeight(context) - 170
                        : 25.appHeight(context),
                width: Platform.isWindows
                    ? 60.appWidth(context)
                    : 100.appWidth(context) - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: VideoShow(
                  url: provider.videos[provider.playerCurrentIndex].video,
                  haveHeader: false,
                ),
              ),
              Padding(
                padding: Platform.isWindows
                    ? const EdgeInsets.symmetric(
                        horizontal: 120,
                        vertical: 12,
                      )
                    : const EdgeInsets.all(12),
                child: Text(
                  provider.videos[provider.playerCurrentIndex].name,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFonts.font15,
                  ),
                ),
              ),
              Container(
                height: 35,
                margin: EdgeInsets.symmetric(
                  horizontal: Platform.isWindows ? 120 : 24,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.greyColor2.withOpacity(0.4),
                ),
                child: Row(
                  children: [
                    for (int index = 0; index < 2; index++)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print("sahkdhkasjadsjdkjal =  =============="+provider.videos[index].video);
                            provider.changeCurrentIndex(index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: provider.currentIndex == index
                                  ? AppColors.blueColor1
                                  : Colors.transparent,
                            ),
                            child: Text(
                              index == 0
                                  ? 'Playlist(${provider.videos.length})'
                                  : 'Description',
                              style: TextStyle(
                                color: provider.currentIndex == index
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                                fontSize: AppFonts.font15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              if (provider.currentIndex == 0)
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: Platform.isWindows ? 120 : 0,
                    ),
                    itemBuilder: (ctx, index) => InkWell(
                      onTap: () {
                        context.push(
                          Scaffold(
                            body: SafeArea(
                              top: !Platform.isWindows,
                              child: VideoShow(
                                url: provider.videos[index].video,
                                haveHeader: false,
                              ),
                              // VideoPlayerWidget(
                              //   url: provider.videos[index].video,
                              // ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                AppImages.play,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                provider.videos[index].name,
                                style: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: AppFonts.font15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (ctx, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: provider.videos.length,
                  ),
                ),
              if (provider.currentIndex == 1)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    child: Text(
                      provider.videos[provider.playerCurrentIndex].description,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
