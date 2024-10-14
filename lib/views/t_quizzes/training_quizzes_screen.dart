import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:courses_app/providers/training_quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';
import 'training_quizzes_questions_screen.dart';

class TrainingQuizzesScreen extends StatefulWidget {
  const TrainingQuizzesScreen({Key? key, required this.id}) : super(key: key);
final int id;

  @override
  State<TrainingQuizzesScreen> createState() => _TrainingQuizzesScreenState();
}

class _TrainingQuizzesScreenState extends State<TrainingQuizzesScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<TrainingQuizProvider>(
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
    return Consumer<TrainingQuizProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: const MainAppBarWidget(
          title: 'Training Quizzes',
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: Platform.isWindows ? 50 : 20,
            vertical: Platform.isWindows ? 30 : 15,
          ),
          itemBuilder: (ctx, index) => SharedItemWidget(
            model: NavigationModel(
              name: provider.trainingQuizzes[index].name,
              image: AppImages.quizIcon,
              index: index,
              onTap: () {
                context.push(
                  TrainingQuizzesQuestionsScreen(
                    model: provider.trainingQuizzes[index],
                  ),
                );
              },
            ),
          ),
          separatorBuilder: (ctx, index) => const SizedBox(
            height: 25,
          ),
          itemCount: provider.trainingQuizzes.length,
        ),
      );
    });
  }
}
