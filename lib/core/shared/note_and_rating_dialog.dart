import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/providers/notes_provider.dart';
import 'package:courses_app/providers/testimonials_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../models/notes_model.dart';
import '../../models/testimonials_model.dart';

class NoteAndRatingDialog extends StatefulWidget {
  const NoteAndRatingDialog({
    Key? key,
    this.isRating = false,
    this.model,
    this.noteModel,
    this.id,
  }) : super(key: key);
  final bool isRating;
  final int? id;
  final TestimonialsModel? model;
  final NotesModel? noteModel;

  @override
  State<NoteAndRatingDialog> createState() => _NoteAndRatingDialogState();
}

class _NoteAndRatingDialogState extends State<NoteAndRatingDialog> {
  String value = '';
  int rate = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.model != null) {
        value = widget.model!.description;
        rate = widget.model!.rate;
      } else if (widget.noteModel != null) {
        value = widget.noteModel!.content;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.model != null
                  ? widget.model!.description
                  : widget.noteModel != null
                      ? widget.noteModel!.content
                      : '',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                this.value = value;
              },
            ),
            if (widget.isRating)
              const SizedBox(
                height: 20,
              ),
            if (widget.isRating)
              RatingBar.builder(
                initialRating:
                    widget.model != null ? widget.model!.rate.toDouble() : 0.0,
                minRating: 1,
                direction: Axis.horizontal,
                unratedColor: AppColors.blueColor1.withAlpha(50),
                itemCount: 5,
                itemSize: 30.0,
                allowHalfRating: false,
                itemPadding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.blueColor1,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rate = rating.toInt();
                  });
                },
                updateOnDrag: true,
              ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                context.pop();
                if (widget.isRating) {
                  if (widget.model != null) {
                    await context
                        .read<TestimonialsProvider>()
                        .updateTestimonial(
                          TestimonialsModel(
                            date: '',
                            description: value,
                            rate: rate,
                            id: widget.model!.id,
                          ),
                        );
                  } else {
                    await context
                        .read<TestimonialsProvider>()
                        .addTestimonial(value, rate);
                  }
                } else {
                  if (widget.noteModel != null) {
                    await context.read<NotesProvider>().updateNote(
                          NotesModel(
                            content: value,
                            image: '',
                            id: widget.noteModel!.id,
                          ),
                        widget.id!
                        );
                  } else {
                    await context.read<NotesProvider>().addNote(
                          value,
                          widget.id!,
                        );
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.blueColor1,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppFonts.font15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
