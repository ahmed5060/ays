import 'dart:io';

import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/network_image_widget.dart';
import 'package:courses_app/providers/training_quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/empty_widget.dart';
import '../../core/shared/main_app_bar_widget.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../models/quiz_model.dart';
import '../../models/question_model.dart';

class TrainingQuizzesQuestionsScreen extends StatefulWidget {
  const TrainingQuizzesQuestionsScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final QuizModel2 model;

  @override
  State<TrainingQuizzesQuestionsScreen> createState() =>
      _TrainingQuizzesQuestionsScreenState();
}

class _TrainingQuizzesQuestionsScreenState
    extends State<TrainingQuizzesQuestionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<TrainingQuizProvider>(context, listen: false).resetSubmit(
        false,
      );
      await Provider.of<TrainingQuizProvider>(context, listen: false)
          .getQuestions(
        widget.model.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        title: '${widget.model.name}-Training',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Platform.isWindows ? 50 : 20,
          vertical: Platform.isWindows ? 30 : 15,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            if (widget.model.examType == ExamType.mcq)
              MCQQuestionsListWidget(
                model: widget.model,
              ),
            if (widget.model.examType == ExamType.other)
              TFQuestionsListWidget2(
                model: widget.model,
              ),
          ],
        ),
      ),
    );
  }
}

class TFQuestionsListWidget2 extends StatefulWidget {
  const TFQuestionsListWidget2({Key? key, required this.model})
      : super(key: key);
  final QuizModel2 model;

  @override
  State<TFQuestionsListWidget2> createState() => _TFQuestionsListWidget2State();
}

class _TFQuestionsListWidget2State extends State<TFQuestionsListWidget2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TrainingQuizProvider>(builder: (context, provider, _) {
        return provider.trainingQuestions[widget.model.id] != null &&
                provider.trainingQuestions[widget.model.id]!.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount:
                    provider.trainingQuestions[widget.model.id]!.length + 1,
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (ctx, index) =>
                    index == provider.trainingQuestions[widget.model.id]!.length
                        ? SizedBox()
                        : TFQuestionWidget2(
                            data: provider
                                .trainingQuestions[widget.model.id]![index],
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

class TFQuestionWidget2 extends StatefulWidget {
  TFQuestionWidget2({
    Key? key,
    required this.data,
    required this.topIndex,
  }) : super(key: key);
  final QuestionModel data;
  final int topIndex;

  @override
  State<TFQuestionWidget2> createState() => _TFQuestionWidget2State();
}

class _TFQuestionWidget2State extends State<TFQuestionWidget2> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingQuizProvider>(builder: (context, provider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.data.questionType == QuestionType.text
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data.question,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: AppFonts.font15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShow = true;
                          });
                        },
                        child: const Text("Show"))
                  ],
                )
              : widget.data.questionType == QuestionType.photo
                  ? NetworkImageWidget(
                      imageUrl: widget.data.question,
                    )
                  : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          for (int index = 0; index < widget.data.answers.length; index++)
            widget.data.answers[index] != "null"
                ? InkWell(
                    onTap: () {
                      provider.changeSelectedMCQ(
                          widget.topIndex, widget.data.answers[index]);
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
                        color: isShow == true
                            ? widget.data.rightAnswer ==
                                    widget.data.answers[index]
                                ? AppColors.blueColor1
                                : null
                            : provider.selectedMCQ[widget.topIndex] ==
                                    widget.data.answers[index]
                                ? AppColors.blueColor1
                                : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.data.answers[index] == "1" ? "true" : "false",
                        style: TextStyle(
                          color: isShow == true
                              ? widget.data.rightAnswer ==
                                      widget.data.answers[index]
                                  ? AppColors.whiteColor
                                  : null
                              : provider.selectedMCQ[widget.topIndex] ==
                                      widget.data.answers[index]
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

class MCQQuestionsListWidget extends StatelessWidget {
  const MCQQuestionsListWidget({Key? key, required this.model})
      : super(key: key);
  final QuizModel2 model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TrainingQuizProvider>(builder: (context, provider, _) {
        return provider.trainingQuestions[model.id] != null &&
                provider.trainingQuestions[model.id]!.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount: provider.trainingQuestions[model.id]!.length + 1,
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (ctx, index) =>
                    index == provider.trainingQuestions[model.id]!.length
                        ? InkWell(
                            onTap: () {
                              provider.resetSubmit(!provider.submit);
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
                                provider.submit ? 'Again' : 'Submit',
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppFonts.font17,
                                ),
                              ),
                            ),
                          )
                        : MCQQuestionWidget(
                            data: provider.trainingQuestions[model.id]![index],
                            topIndex: index,
                            submit: provider.submit,
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
  final QuizModel2 model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TrainingQuizProvider>(builder: (context, provider, _) {
        return provider.trainingQuestions[model.id] != null &&
                provider.trainingQuestions[model.id]!.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount: provider.trainingQuestions[model.id]!.length,
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (ctx, index) => ShortAnswerQuestionWidget(
                  data: provider.trainingQuestions[model.id]![index],
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

class ShortAnswerQuestionWidget extends StatefulWidget {
  const ShortAnswerQuestionWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final QuestionModel data;

  @override
  State<ShortAnswerQuestionWidget> createState() =>
      _ShortAnswerQuestionWidgetState();
}

class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
  bool show = false;

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
          crossAxisAlignment: widget.data.questionType == QuestionType.photo
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data.questionType == QuestionType.text
                    ? SizedBox(
                        width: 50.appWidth(context),
                        child: Text(
                          widget.data.question,
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: AppFonts.font15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : widget.data.questionType == QuestionType.photo
                        ? NetworkImageWidget(
                            imageUrl: widget.data.question,
                          )
                        : const SizedBox(),
                InkWell(
                  onTap: () {
                    show = !show;
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Answer',
                        style: TextStyle(
                          fontSize: AppFonts.font12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.blueColor1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: show
                            ? const Icon(
                                Icons.check,
                                size: 10,
                                color: AppColors.blueColor1,
                              )
                            : null,
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (show)
              const SizedBox(
                height: 12,
              ),
            if (show)
              SizedBox(
                width: 75.appWidth(context),
                child: Text(
                  "widget.data.answer",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MCQQuestionWidget extends StatelessWidget {
  const MCQQuestionWidget(
      {Key? key,
      required this.data,
      required this.topIndex,
      required this.submit})
      : super(key: key);
  final QuestionModel data;
  final int topIndex;
  final bool submit;

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingQuizProvider>(builder: (context, provider, _) {
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
              : data.questionType == QuestionType.text
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
                        color: provider.submit &&
                                data.rightAnswer == data.answers[index]
                            ? AppColors.greenColor
                            : provider.selectedMCQ[topIndex] ==
                                    data.answers[index]
                                ? AppColors.blueColor1
                                : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.answers[index],
                        style: TextStyle(
                          color: provider.selectedMCQ[topIndex] ==
                                  data.answers[index]
                              ? AppColors.whiteColor
                              : null,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
        ],
      );
    });
  }
}
