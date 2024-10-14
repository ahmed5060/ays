import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../models/message_model.dart';
import '../../../providers/chat_provider.dart';

class ChatBottomWidget extends StatelessWidget {
  ChatBottomWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, _) {
      return Container(
        height: 80,
        color: AppColors.whiteColor,
        alignment: Alignment.center,
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.greyColor1,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.only(
                  right: 6,
                ),
                child: TextField(
                  controller: messageController,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  scrollPadding: const EdgeInsets.all(0),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    hintText: 'Write a message',
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
              ),
              onPressed: () async {
                if (messageController.text.isNotEmpty) {
                  await provider.sendMessage(
                    MessageModel(
                      message: messageController.text,
                      date: DateTime.now().toIso8601String(),
                      name: model.name,
                      type: MessageType.text,
                      id: model.id,
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.send,
                color: AppColors.blueColor1,
              ),
            ),
          ],
        ),
      );
    });
  }
}
