import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';
import '../../providers/quiz_provider.dart';
import 'quizzes_screen.dart';

class QuizzesSubSectionsScreen extends StatefulWidget {
  const QuizzesSubSectionsScreen({Key? key, required this.id})
      : super(key: key);
  final int id;

  @override
  State<QuizzesSubSectionsScreen> createState() =>
      _QuizzesSubSectionsScreenState();
}

class _QuizzesSubSectionsScreenState extends State<QuizzesSubSectionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<QuizProvider>(
        context,
        listen: false,
      ).getSections(
        sectionId: widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<QuizProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              const MainAppBarWidget(
                title: '',
              ),
              Expanded(
                child: provider.subSections.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: Platform.isWindows ? 50 : 20,
                          vertical: Platform.isWindows ? 30 : 15,
                        ),
                        itemBuilder: (ctx, index) => SharedItemWidget(
                          model: NavigationModel(
                            name: provider.subSections[index].title,
                            image: AppImages.folder,
                            index: index,
                            onTap: () {
                              if (provider.subSections[index].haveSections) {
                                context.pushReplacement(
                                  QuizzesSubSectionsScreen(
                                    id: provider.subSections[index].id,
                                  ),
                                );
                              } else {
                                context.pushReplacement(
                                  QuizzesScreen(
                                    id: provider.subSections[index].id,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        separatorBuilder: (ctx, index) => const SizedBox(
                          height: 25,
                        ),
                        itemCount: provider.subSections.length,
                      )
                    : Center(
                        child: provider.getQuizzesLoading
                            ? const LoadingWidget()
                            : const EmptyWidget(),
                      ),
              )
            ],
          );
        }),
      ),
    );
  }
}
