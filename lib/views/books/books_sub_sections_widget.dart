import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:courses_app/providers/books_provider.dart';
import 'package:courses_app/views/books/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';

class BooksSubSectionsScreen extends StatefulWidget {
  const BooksSubSectionsScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<BooksSubSectionsScreen> createState() => _BooksSubSectionsScreenState();
}

class _BooksSubSectionsScreenState extends State<BooksSubSectionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<BooksProvider>(
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
        child: Consumer<BooksProvider>(builder: (context, provider, _) {
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
                                  BooksSubSectionsScreen(
                                    id: provider.subSections[index].id,
                                  ),
                                );
                              } else {
                                context.pushReplacement(
                                  BooksScreen(
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
                        child: provider.getBooksLoading
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
