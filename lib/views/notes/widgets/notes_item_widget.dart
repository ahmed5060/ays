import 'dart:io';

import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/note_and_rating_dialog.dart';
import '../../../models/notes_model.dart';
import '../../../models/testimonials_model.dart';

class NotesItemWidget extends StatelessWidget {
  const NotesItemWidget({
    Key? key,
    this.isRating = false,
    this.model,
    this.noteModel,
     this.id,
  }) : super(key: key);
  final bool isRating;
  final TestimonialsModel? model;
  final NotesModel? noteModel;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isRating ? 220 : 200,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 12,
              color: AppColors.blueColor1,
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 100.appWidth(context) - (Platform.isWindows ? 175 : 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.read<AuthProvider>().userModel.name,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: AppFonts.font15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => NoteAndRatingDialog(
                              isRating: isRating,
                              model: model,
                              id: id,
                              noteModel: noteModel,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_note_outlined,
                          color: AppColors.blueColor1,
                        ),
                      ),
                    ],
                  ),
                  if (model != null)
                    Text(
                      model!.date,
                      style: const TextStyle(
                        color: AppColors.greyColor1,
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts.font12,
                      ),
                    ),
                  if (model != null)
                    const SizedBox(
                      height: 12,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Text(
                      model!=null?model!.description:noteModel!.content,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  if (isRating)
                    const SizedBox(
                      height: 12,
                    ),
                  if (isRating&&model!=null)
                    Row(
                      children: [
                        for (int index = 0; index < model!.rate; index++)
                          const Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Icon(
                              Icons.star,
                              color: AppColors.blueColor1,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
