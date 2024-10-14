// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoShow extends StatefulWidget {
  final String url;
  final bool haveHeader;
  const VideoShow({
    Key? key,
    required this.url,
    required this.haveHeader,
  }) : super(key: key);

  @override
  _VideoShowState createState() => _VideoShowState();
}

class _VideoShowState extends State<VideoShow> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      '${widget.url}',
    )..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
      // You can customize other options here
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.haveHeader
        ? Center(
            child: SizedBox(
                height: 200,
                child: Center(
                  child: _videoPlayerController.value.isInitialized
                      ? Chewie(controller: _chewieController)
                      : const CircularProgressIndicator(),
                )))
        : Center(
            child: _videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController)
                : const CircularProgressIndicator(),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
