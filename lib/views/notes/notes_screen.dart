import 'dart:io';

import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/note_and_rating_dialog.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/main_app_bar_widget.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/notes_item_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<NotesProvider>(context, listen: false).getNotes(
        widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Platform.isWindows ? 50 : 0,
        vertical: Platform.isWindows ? 30 : 0,
      ),
      child: Consumer<NotesProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            MainAppBarWidget(
              title: 'Notes',
              noBackPressed: Platform.isWindows ? false : true,
              backPressed: Platform.isWindows
                  ? () {
                      context.read<NavigationProvider>().changeCurrentIndex(0);
                    }
                  : null,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => NoteAndRatingDialog(
                    id: widget.id,
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
                      'Add Note',
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
            Expanded(
              child: provider.notesList[widget.id] != null &&
                      provider.notesList[widget.id]!.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      itemBuilder: (ctx, index) => NotesItemWidget(
                        noteModel: provider.notesList[widget.id]![index],
                        id: widget.id,
                      ),
                      separatorBuilder: (ctx, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: provider.notesList[widget.id]!.length,
                    )
                  : Center(
                      child: provider.getNotesLoading
                          ? const LoadingWidget()
                          : const EmptyWidget(),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
