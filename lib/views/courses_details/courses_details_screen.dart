import 'dart:io';

import 'package:courses_app/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../models/course_model.dart';
import '../books/books_sections_screen.dart';
import '../home/home_screen.dart';
import '../notes/notes_screen.dart';
import '../quizzes/quizzes_sections_screen.dart';
import '../t_quizzes/training_quizzes_sections_screen.dart';
import '../videos/videos_sections_screen.dart';

class CoursesDetailsScreen extends StatelessWidget {
  const CoursesDetailsScreen({
    Key? key,
    required this.courseModel,
  }) : super(key: key);
  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          if (provider.currentIndex == 0) {
            return true;
          }
          provider.changeCurrentIndex(0);
          return false;
        },
        child: Scaffold(
          body: provider.currentIndex == 0
              ? HomeScreen(
            courseModel: courseModel,
                )
              : provider.currentIndex == 1
                  ? SectionsScreen(
                      id: courseModel.id,
                    )
                  : provider.currentIndex == 2
                      ? BooksSectionsScreen(
                          id: courseModel.id,
                        )
                      : provider.currentIndex == 3
                          ? QuizzesSectionsScreen(
                              id: courseModel.id,
                            )
                          : provider.currentIndex == 4
                              ? TrainingQuizzesSectionsScreen(
                                  id: courseModel.id,
                                )
                              : NotesScreen(
                                  id: courseModel.id,
                                ),
          bottomNavigationBar: Platform.isWindows
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  unselectedFontSize: AppFonts.font10,
                  selectedFontSize: AppFonts.font12,
                  elevation: 10,
                  items: provider.items,
                  onTap: provider.changeCurrentIndex,
                  backgroundColor: AppColors.whiteColor,
                  currentIndex: provider.currentIndex,
                ),
        ),
      );
    });
  }
}
