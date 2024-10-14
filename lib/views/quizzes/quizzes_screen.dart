import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:courses_app/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';
import 'quizzes_questions_screen.dart';

class QuizzesScreen extends StatefulWidget {
  const QuizzesScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<QuizProvider>(
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
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: const MainAppBarWidget(
          title: 'Quizzes',
        ),
        body: provider.getQuizzesLoading
            ? const Center(
                child: LoadingWidget(),
              )
            : provider.quizzes.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: Platform.isWindows ? 50 : 20,
                      vertical: Platform.isWindows ? 30 : 15,
                    ),
                    itemBuilder: (ctx, index) => SharedItemWidget(
                      model: NavigationModel(
                        name: provider.quizzes[index].name,
                        image: AppImages.quizIcon,
                        index: index,
                        onTap: () {
                          
                          context.push(
                            QuizzesQuestionsScreen(
                                model: provider.quizzes[index],
                                duration2: provider.quizzes[index].duration),
                          );
                        },
                      ),
                    ),
                    separatorBuilder: (ctx, index) => const SizedBox(
                      height: 25,
                    ),
                    itemCount: provider.quizzes.length,
                  )
                : const Center(
                    child: EmptyWidget(),
                  ),
      );
    });
  }
}
