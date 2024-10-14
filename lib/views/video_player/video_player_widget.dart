import 'dart:async';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_colors.dart';
import '../../providers/auth_provider.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.url,
    this.haveHeader = true,
  }) : super(key: key);
  final String url;
  final bool haveHeader;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  var overlay;
  OverlayEntry? entry;
  // final _meeduPlayerController = MeeduPlayerController(
  //   controlsStyle: ControlsStyle.primary,
  // );

  StreamSubscription? _playerEventSubs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _init();
    });
    Future.delayed(Duration.zero, () {
      overlay = Overlay.of(context);
      entry = OverlayEntry(
        builder: (ctx) => Positioned(
          top: context.topPadding() + 120,
          left: 15,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.black38Color,
              ),
              child: Text(
                context.read<AuthProvider>().userModel.id.toString(),
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
      overlay!.insert(entry);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _playerEventSubs?.cancel();
    //  _meeduPlayerController.dispose();
    overlay = null;
    entry!.remove();
    entry = null;
    super.dispose();
  }

  // _init() async {
  //   await _meeduPlayerController.setDataSource(
  //     DataSource(
  //       type: DataSourceType.network,
  //       source: widget.url,
  //     ),
  //     autoplay: true,
  //     looping: false,
  //   );
  // }

  Widget get header {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CupertinoButton(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // close the fullscreen
              Navigator.maybePop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      return const Text("");
      // MeeduVideoPlayer(
      //   controller: _meeduPlayerController,
      //   header: (context, controller, responsive) =>
      //       widget.haveHeader ? header : const SizedBox(),
      // );
    });
  }
}
