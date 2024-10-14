// import 'package:audioplayers/audioplayers.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/extension/size_extension.dart';
// import '../../../models/message_model.dart';
//
// import '../../../core/utils/app_colors.dart';
// import '../../../core/utils/app_images.dart';
// import '../../../providers/chat_provider.dart';
//
// class VoiceMessageWidget extends StatelessWidget {
//   const VoiceMessageWidget({
//     Key? key,
//     required this.messageModel,
//   }) : super(key: key);
//   final MessageModel messageModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return messageModel.unReadCount == 0
//         ? MyMessageWidget(
//             messageModel: messageModel,
//           )
//         : OtherMessageWidget(
//             messageModel: messageModel,
//           );
//   }
// }
//
// class MyMessageWidget extends StatefulWidget {
//   const MyMessageWidget({
//     Key? key,
//     required this.messageModel,
//   }) : super(key: key);
//   final MessageModel messageModel;
//
//   @override
//   State<MyMessageWidget> createState() => _MyMessageWidgetState();
// }
//
// class _MyMessageWidgetState extends State<MyMessageWidget> {
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//
//   Duration duration = Duration.zero;
//
//   Duration position = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     audioPlayer.setSourceDeviceFile(
//       widget.messageModel.message,
//     );
//     setState(() {});
//     audioPlayer.onPlayerStateChanged.listen((event) {
//       setState(() {
//         isPlaying = event == PlayerState.playing;
//       });
//       setState(() {});
//     });
//     audioPlayer.onDurationChanged.listen((event) {
//       setState(() {
//         duration = event;
//       });
//     });
//     audioPlayer.onPositionChanged.listen((event) {
//       setState(() {
//         position = event;
//       });
//     });
//     audioPlayer.onPlayerComplete.listen((event) {
//       setState(() {
//         position = Duration.zero;
//         isPlaying = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String twoDigits(n) => n.toString().padLeft(2, '0');
//     String twoDigitsMin = twoDigits(isPlaying?position.inMinutes.remainder(60):duration.inMinutes.remainder(60));
//     String twoDigitsSec = twoDigits(isPlaying?position.inSeconds.remainder(60):duration.inSeconds.remainder(60));
//     return Consumer<ChatProvider>(builder: (context, provider, _) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 100.appWidth(context) - 80,
//                 height: 70,
//                 padding: const EdgeInsets.all(8),
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(10),
//                     topLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(0),
//                     bottomLeft: Radius.circular(10),
//                   ),
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.blueColor1,
//                       AppColors.blueColor2,
//                     ],
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             if (isPlaying) {
//                               await audioPlayer.pause();
//                             } else {
//                               await audioPlayer.play(
//                                 DeviceFileSource(
//                                   widget.messageModel.message,
//                                 ),
//                               );
//                             }
//                           },
//                           child: Icon(
//                             isPlaying ? Icons.pause : Icons.play_arrow,
//                             color: AppColors.greyColor1,
//                             size: 30,
//                           ),
//                         ),
//                         Expanded(
//                           child: SliderTheme(
//                             data: SliderThemeData(
//                               overlayShape: SliderComponentShape.noThumb,
//                               thumbShape: const RoundSliderThumbShape(
//                                 enabledThumbRadius: 6,
//                               ),
//                             ),
//                             child: Slider(
//                               value: position.inSeconds.toDouble(),
//                               min: 0.0,
//                               max: duration.inSeconds.toDouble(),
//                               onChanged: (value) async {
//                                 final p = Duration(seconds: value.toInt());
//                                 await audioPlayer.seek(p);
//                               },
//                               activeColor: AppColors.blueColor1,
//                               inactiveColor: Colors.white70,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           '$twoDigitsMin:$twoDigitsSec',
//                           style: const TextStyle(
//                             color: AppColors.greyColor1,
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 widget.messageModel.time,
//                 style: const TextStyle(
//                   color: AppColors.greyColor1,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
//
// class OtherMessageWidget extends StatefulWidget {
//   const OtherMessageWidget({
//     Key? key,
//     required this.messageModel,
//   }) : super(key: key);
//   final MessageModel messageModel;
//
//   @override
//   State<OtherMessageWidget> createState() => _OtherMessageWidgetState();
// }
//
// class _OtherMessageWidgetState extends State<OtherMessageWidget> {
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//
//   Duration duration = Duration.zero;
//
//   Duration position = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     audioPlayer.setSourceDeviceFile(
//       widget.messageModel.message,
//     );
//     setState(() {});
//     audioPlayer.onPlayerStateChanged.listen((event) {
//       setState(() {
//         isPlaying = event == PlayerState.playing;
//       });
//       setState(() {});
//     });
//     audioPlayer.onDurationChanged.listen((event) {
//       setState(() {
//         duration = event;
//       });
//     });
//     audioPlayer.onPositionChanged.listen((event) {
//       setState(() {
//         position = event;
//       });
//     });
//     audioPlayer.onPlayerComplete.listen((event) {
//       setState(() {
//         position = Duration.zero;
//         isPlaying = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String twoDigits(n) => n.toString().padLeft(2, '0');
//     String twoDigitsMin = twoDigits(isPlaying?position.inMinutes.remainder(60):duration.inMinutes.remainder(60));
//     String twoDigitsSec = twoDigits(isPlaying?position.inSeconds.remainder(60):duration.inSeconds.remainder(60));
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               width: 100.appWidth(context) - 80,
//               height: 70,
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(10),
//                   topLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                   bottomLeft: Radius.circular(0),
//                 ),
//                 color: AppColors.greyColor1,
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SliderTheme(
//                           data: SliderThemeData(
//                             overlayShape: SliderComponentShape.noThumb,
//                             thumbShape: const RoundSliderThumbShape(
//                               enabledThumbRadius: 6,
//                             ),
//                           ),
//                           child: Slider(
//                             value: position.inSeconds.toDouble(),
//                             min: 0.0,
//                             max: duration.inSeconds.toDouble(),
//                             onChanged: (value) async {
//                               final position = Duration(seconds: value.toInt());
//                               await audioPlayer.seek(position);
//                             },
//                             activeColor: AppColors.blueColor1,
//                             inactiveColor: Colors.white70,
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           if (isPlaying) {
//                             await audioPlayer.pause();
//                           } else {
//                             await audioPlayer.play(
//                               DeviceFileSource(
//                                 widget.messageModel.message,
//                               ),
//                             );
//                           }
//                         },
//                         child: Icon(
//                           isPlaying ? Icons.pause : Icons.play_arrow,
//                           color: AppColors.blueColor1,
//                           size: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         '$twoDigitsMin:$twoDigitsSec',
//                         style: TextStyle(
//                           color: AppColors.baseColor,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               widget.messageModel.time,
//               style: const TextStyle(
//                 color: AppColors.greyColor1,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
