import 'package:courses_app/core/extension/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/shared/empty_widget.dart';
import '../../core/shared/loading_widget.dart';
import '../../core/utils/app_colors.dart';
import '../../models/message_model.dart';
import '../../providers/chat_provider.dart';
import 'widgets/chat_bottom_widget.dart';
import 'widgets/text_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<ChatProvider>(context, listen: false).singleChatListener(
        widget.model.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            ),
          ),
          centerTitle: true,
          titleSpacing: 0,
          title: Text(
            widget.model.name,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: provider.messagesMap[widget.model.id] != null &&
                      provider.messagesMap[widget.model.id]!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: ListView.separated(
                        reverse: true,
                        itemBuilder: (ctx, index) => TextMessageWidget(
                          model: provider.messagesMap[widget.model.id]![
                              provider.messagesMap[widget.model.id]!.length -
                                  1 -
                                  index],
                        ),
                        separatorBuilder: (ctx, index) => const SizedBox(
                          height: 12,
                        ),
                        itemCount:
                            provider.messagesMap[widget.model.id]!.length,
                      ),
                    )
                  : Center(
                      child: provider.getMessagesLoading
                          ? const LoadingWidget()
                          : const EmptyWidget(),
                    ),
            ),
            ChatBottomWidget(
              model: widget.model,
            ),
          ],
        ),
      );
    });
  }
}
