// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/network_image_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';

import '../../core/shared/empty_widget.dart';
import '../../core/shared/main_app_bar_widget.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../models/question_model.dart';
import '../../models/quiz_model.dart';
import '../../providers/quiz_provider.dart';

bool isSubmited = false;

class QuizzesQuestionsScreen extends StatefulWidget {
  QuizzesQuestionsScreen({
    Key? key,
    required this.model,
    required this.duration2,
  }) : super(key: key);
  final QuizModel model;
  final int duration2;

  @override
  State<QuizzesQuestionsScreen> createState() => _QuizzesQuestionsScreenState();
}

Timer? timer;
final QuizProvider quizProvider = QuizProvider();

class _QuizzesQuestionsScreenState extends State<QuizzesQuestionsScreen> {
  Duration duration = Duration(
    minutes: 15,
  );

  @override
  void initState() {
    super.initState();
    // Initialize the duration with the provided duration2 value
    duration = Duration(minutes: widget.duration2);
    // print("alllllllllllllllllllllllllllll" + widget.model.examType.name);
    Future.delayed(Duration.zero, () async {
      await Provider.of<QuizProvider>(context, listen: false).getQuestions(
        widget.model.id,
      );
    });

    if (widget.model.examType == ExamType.mcq ||
        widget.model.examType == ExamType.other) {
      Future.delayed(
          Duration(
            minutes: widget.duration2,
          ), () async {
        timer!.cancel();
        isSubmited == false
            ? await Provider.of<QuizProvider>(context, listen: false)
                .submit(widget.model.id)
            : null;
      });

      timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ),
        (timer) {
          duration = Duration(
            seconds: duration.inSeconds - 1,
          );
          setState(() {});
        },
      );
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
      if (mounted) {
        try {
          Provider.of<QuizProvider>(context, listen: false)
              .submit(widget.model.id);
        } catch (e) {}
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        title: widget.model.name,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Platform.isWindows ? 50 : 20,
          vertical: Platform.isWindows ? 30 : 15,
        ),
        child: Column(
          children: [
            if (widget.model.examType == ExamType.mcq ||
                widget.model.examType == ExamType.other)
              const SizedBox(
                height: 10,
              ),
            if (widget.model.examType == ExamType.mcq ||
                widget.model.examType == ExamType.other)
              isSubmited == false
                  ? Row(
                      children: [
                        Image.asset(
                          AppImages.clock,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${widget.duration2}',
                          style: TextStyle(
                            fontSize: AppFonts.font16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          (duration.inSeconds - ((duration.inMinutes) * 60)) ==
                                  0
                              ? '${duration.inMinutes}:00'
                              : '${duration.inMinutes}:${Duration(seconds: (duration.inSeconds - ((duration.inMinutes) * 60))).inSeconds}',
                          style: const TextStyle(
                            fontSize: AppFonts.font16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueColor1,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            const SizedBox(
              height: 10,
            ),
            if (widget.model.examType == ExamType.mcq)
              MCQQuestionsListWidget(
                model: widget.model,
              ),
            if (widget.model.examType == ExamType.shortAnswer)
              ShortAnswerQuestionsListWidget(
                model: widget.model,
              ),
            if (widget.model.examType == ExamType.other)
              TFQuestionsListWidget(
                model: widget.model,
              ),
          ],
        ),
      ),
    );
  }
}

class TFQuestionsListWidget extends StatefulWidget {
  const TFQuestionsListWidget({Key? key, required this.model})
      : super(key: key);
  final QuizModel model;

  @override
  State<TFQuestionsListWidget> createState() => _TFQuestionsListWidgetState();
}

class _TFQuestionsListWidgetState extends State<TFQuestionsListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<QuizProvider>(builder: (context, provider, _) {
        isSubmited = provider.questions[widget.model.id]?.isNotEmpty == true &&
            provider.questions[widget.model.id]!.isNotEmpty &&
            provider.questions[widget.model.id]!.last.submitted == true;

        return provider.questions[widget.model.id] != null &&
                provider.questions[widget.model.id]!.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount: provider.questions[widget.model.id]!.length + 1,
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (ctx, index) => index ==
                        provider.questions[widget.model.id]!.length
                    ? InkWell(
                        onTap: provider.submitLoading
                            ? () {}
                            : () async {
                                provider.questions[widget.model.id]![index - 1]
                                            .submitted ==
                                        false
                                    ? await provider.submit(widget.model.id)
                                    : null;
                              },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.blueColor1,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: Text(
                            provider.questions[widget.model.id]![index - 1]
                                        .submitted ==
                                    false
                                ? provider.submitLoading
                                    ? 'Please wait...'
                                    : 'Submit'
                                : "Grade ${provider.questions[widget.model.id]![index - 1].grade}",
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: AppFonts.font17,
                            ),
                          ),
                        ),
                      )
                    : TFQuestionWidget(
                        data: provider.questions[widget.model.id]![index],
                        topIndex: index,
                      ),
              )
            : Center(
                child: provider.getQuestionsLoading
                    ? const LoadingWidget()
                    : const EmptyWidget(),
              );
      }),
    );
  }
}

class MCQQuestionsListWidget extends StatelessWidget {
  const MCQQuestionsListWidget({Key? key, required this.model})
      : super(key: key);
  final QuizModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<QuizProvider>(builder: (context, provider, _) {
        isSubmited = provider.questions[model.id]?.isNotEmpty == true &&
            provider.questions[model.id]!.isNotEmpty &&
            provider.questions[model.id]!.last.submitted == true;
        return provider.questions[model.id] != null &&
                provider.questions[model.id]!.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount: provider.questions[model.id]!.length + 1,
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (ctx, index) =>
                    index == provider.questions[model.id]!.length
                        ? InkWell(
                            onTap: provider.submitLoading
                                ? () {}
                                : () async {
                                    provider.questions[model.id]![index - 1]
                                                .submitted ==
                                            false
                                        ? await provider.submit(model.id)
                                        : null;
                                  },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.blueColor1,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Text(
                                provider.questions[model.id]![index - 1]
                                            .submitted ==
                                        false
                                    ? provider.submitLoading
                                        ? 'Please wait...'
                                        : 'Submit'
                                    : "Grade ${provider.questions[model.id]![index - 1].grade}",
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppFonts.font17,
                                ),
                              ),
                            ),
                          )
                        : MCQQuestionWidget(
                            data: provider.questions[model.id]![index],
                            topIndex: index,
                          ),
              )
            : Center(
                child: provider.getQuestionsLoading
                    ? const LoadingWidget()
                    : const EmptyWidget(),
              );
      }),
    );
  }
}

class ShortAnswerQuestionsListWidget extends StatelessWidget {
  const ShortAnswerQuestionsListWidget({Key? key, required this.model})
      : super(key: key);
  final QuizModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<QuizProvider>(builder: (context, provider, _) {
        return provider.questions[model.id] != null &&
                provider.questions[model.id]!.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount: provider.questions[model.id]!.length,
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (ctx, index) => ShortAnswerQuestionWidget(
                  data: provider.questions[model.id]![index],
                ),
              )
            : Center(
                child: provider.getQuestionsLoading
                    ? const LoadingWidget()
                    : const EmptyWidget(),
              );
      }),
    );
  }
}

class ShortAnswerQuestionWidget extends StatelessWidget {
  const ShortAnswerQuestionWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final QuestionModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.blueColor1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: const BoxDecoration(
          //borderRadius: BorderRadius.circular(8),
          border: BorderDirectional(
            start: BorderSide(
              color: AppColors.blueColor1,
              width: 12,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: data.questionType == QuestionType.photo
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            data.questionType == QuestionType.text
                ? SizedBox(
                    width: 70.appWidth(context),
                    child: Text(
                      data.question,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: AppFonts.font15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : data.questionType == QuestionType.photo
                    ? NetworkImageWidget(
                        imageUrl: data.question,
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class MCQQuestionWidget extends StatelessWidget {
  const MCQQuestionWidget({
    Key? key,
    required this.data,
    required this.topIndex,
  }) : super(key: key);
  final QuestionModel data;
  final int topIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data.questionType == QuestionType.text
              ? Text(
                  data.question,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: AppFonts.font15,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : data.questionType == QuestionType.photo
                  ? NetworkImageWidget(
                      imageUrl: data.question,
                    )
                  : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          for (int index = 0; index < data.answers.length; index++)
            data.answers[index] != "null"
                ? InkWell(
                    onTap: () {
                      data.submitted == false
                          ? provider.changeSelectedMCQ(
                              topIndex, data.answers[index])
                          : null;
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.blueColor1,
                        ),
                        color: data.submitted == true
                            ? data.rightAnswer == data.answers[index]
                                ? AppColors.blueColor1
                                : null
                            : provider.selectedMCQ[topIndex] ==
                                    data.answers[index]
                                ? AppColors.blueColor1
                                : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.answers[index],
                        style: TextStyle(
                          color: data.submitted == true
                              ? data.rightAnswer == data.answers[index]
                                  ? AppColors.whiteColor
                                  : null
                              : provider.selectedMCQ[topIndex] ==
                                      data.answers[index]
                                  ? AppColors.whiteColor
                                  : null,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
        ],
      );
    });
  }
}

//
class TFQuestionWidget extends StatelessWidget {
  const TFQuestionWidget({
    Key? key,
    required this.data,
    required this.topIndex,
  }) : super(key: key);
  final QuestionModel data;
  final int topIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data.questionType == QuestionType.text
              ? Text(
                  data.question,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: AppFonts.font15,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : data.questionType == QuestionType.photo
                  ? NetworkImageWidget(
                      imageUrl: data.question,
                    )
                  : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          for (int index = 0; index < data.answers.length; index++)
            data.answers[index] != "null"
                ? InkWell(
                    onTap: () {
                      provider.changeSelectedMCQ(topIndex, data.answers[index]);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.blueColor1,
                        ),
                        color: data.submitted == true
                            ? data.rightAnswer == data.answers[index]
                                ? AppColors.blueColor1
                                : null
                            : provider.selectedMCQ[topIndex] ==
                                    data.answers[index]
                                ? AppColors.blueColor1
                                : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.answers[index] == "1" ? "true" : "false",
                        style: TextStyle(
                          color: data.submitted == true
                              ? data.rightAnswer == data.answers[index]
                                  ? AppColors.whiteColor
                                  : null
                              : provider.selectedMCQ[topIndex] ==
                                      data.answers[index]
                                  ? AppColors.whiteColor
                                  : null,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
        ],
      );
    });
  }
}
