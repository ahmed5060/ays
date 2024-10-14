import 'package:flutter/material.dart';
import '../../../core/helper/app_helper.dart';
import '../../../models/message_model.dart';
import 'my_message_item_widget.dart';
import 'other_message_item_widget.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return model.id == AppHelper.getUserId()
        ? MyMessageItemWidget(
            model: model,
          )
        : OtherMessageItemWidget(
            model: model,
          );
  }
}
