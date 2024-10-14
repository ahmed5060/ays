import 'dart:io';

import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/note_and_rating_dialog.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/testimonials_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/main_app_bar_widget.dart';
import '../notes/widgets/notes_item_widget.dart';

class TestimonialsScreen extends StatefulWidget {
  const TestimonialsScreen({Key? key}) : super(key: key);

  @override
  State<TestimonialsScreen> createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<TestimonialsProvider>(context, listen: false)
          .getTestimonials();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarWidget(
        title: 'Testimonials',
      ),
      body: Consumer<TestimonialsProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isWindows ? 30 : 0,
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => const NoteAndRatingDialog(
                      isRating: true,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 90,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Testimonial',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: AppFonts.font15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.asset(
                        AppImages.add,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: provider.testimonialsList.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: Platform.isWindows ? 50 : 20,
                        vertical: Platform.isWindows ? 30 : 15,
                      ),
                      itemBuilder: (ctx, index) => NotesItemWidget(
                        isRating: true,
                        model: provider.testimonialsList[index],
                      ),
                      separatorBuilder: (ctx, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: provider.testimonialsList.length,
                    )
                  : provider.getTestimonialsLoading
                      ? const LoadingWidget()
                      : const EmptyWidget(),
            ),
          ],
        );
      }),
    );
  }
}
