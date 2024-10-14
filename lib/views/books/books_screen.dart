import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:courses_app/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';
import 'book_details_screen.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<BooksProvider>(
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
    return Consumer<BooksProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: const MainAppBarWidget(
          title: 'Books',
        ),
        body: provider.books.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: Platform.isWindows ? 50 : 20,
                  vertical: Platform.isWindows ? 30 : 15,
                ),
                itemBuilder: (ctx, index) => SharedItemWidget(
                  model: NavigationModel(
                      name: provider.books[index].title,
                      image: AppImages.book,
                      index: index,
                      onTap: () {
                        context.push(
                          BookDetailsScreen(
                            model: provider.books[index],
                          ),
                        );
                      }),
                ),
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 25,
                ),
                itemCount: provider.books.length,
              )
            : Center(
                child: provider.getBooksLoading
                    ? const LoadingWidget()
                    : const EmptyWidget(),
              ),
      );
    });
  }
}
