import 'dart:io';
import 'package:flutter/material.dart';
import '../core/helper/app_helper.dart';
import '../core/utils/app_constants.dart';
import '../models/message_model.dart';
import '../models/send_message_model.dart';
import '../models/user_model.dart';

class ChatProvider extends ChangeNotifier {
  Map<int, List<MessageModel>> messagesMap = {};

  bool getMessagesLoading = false;

  void singleChatListener(int id) {
    getMessagesLoading = true;
    notifyListeners();
    try {
      String doc = id.toString();
      //
      // FirebaseFirestore.instance
      //     .collection(
      //       AppConstants.messagesCollection,
      //     )
      //     .doc(doc)
      //     .snapshots()
      //     .listen((event) {
      //   if (event.data() != null) {
      //     if (event.data()![AppConstants.messagesCollection] != null) {
      //       messagesMap[id] = [];
      //       final messagesList =
      //           event.data()![AppConstants.messagesCollection] as List;
      //
      //       for (var value in messagesList) {
      //         messagesMap[id]!.add(
      //           MessageModel.fromJson(value),
      //         );
      //       }
      //     }
      //   }
      //   notifyListeners();
      // });
    } on SocketException {
      singleChatListener(id);
    } catch (e) {
      singleChatListener(id);
    }
    getMessagesLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(MessageModel model) async {
    try {
      final UserModel userModel = UserModel.fromJson(AppHelper.getUserModel());

      String doc = model.id.toString();

      // List messages = ((await FirebaseFirestore.instance
      //                 .collection(
      //                   AppConstants.messagesCollection,
      //                 )
      //                 .doc(doc)
      //                 .get())
      //             .data() ??
      //         {})[AppConstants.messagesCollection] ??
      //     [];

      // messages.add(
      //   SendMessageModel(
      //     message: model.message,
      //     date: DateTime.now().toIso8601String(),
      //     type: MessageType.text,
      //     id: userModel.id,
      //     name: userModel.name,
      //   ).toJson(),
      // );
      // await FirebaseFirestore.instance
      //     .collection(
      //       AppConstants.messagesCollection,
      //     )
      //     .doc(doc)
      //     .set({
      //   AppConstants.messagesCollection: messages,
      // });
    } on SocketException {
    } catch (e) {}
    notifyListeners();
  }
}
