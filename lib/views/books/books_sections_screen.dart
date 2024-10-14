import 'dart:io';

import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/helper/api_helper.dart';
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
import 'books_sub_sections_widget.dart';
import '../../providers/navigation_provider.dart';

class BooksSectionsScreen extends StatefulWidget {
  const BooksSectionsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<BooksSectionsScreen> createState() => _BooksSectionsScreenState();
}

bool isActive = false;
bool isloading = true;

Future<void> checkSection(int id) async {
  // getQuestionsLoading = true;
  // notifyListeners();

  final response = await APIHelper.apiCall(
    type: APICallType.get,
    url: '${EndPoints.checkSection}$id',
  );

  if (response.success) {
    if (response.data != null && response.data['data'] != null) {
      isActive = response.data["data"]["active"];
      print(response.data["data"]["active"]);
    }
  }
}

void _showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}

class _BooksSectionsScreenState extends State<BooksSectionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<BooksProvider>(
        context,
        listen: false,
      ).getSections(
        courseId: widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<BooksProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            MainAppBarWidget(
              title: 'Books Section',
              noBackPressed: Platform.isWindows ? false : true,
              backPressed: Platform.isWindows
                  ? () {
                      context.read<NavigationProvider>().changeCurrentIndex(0);
                    }
                  : null,
            ),
            Expanded(
              child: provider.sections.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: Platform.isWindows ? 50 : 20,
                        vertical: Platform.isWindows ? 30 : 15,
                      ),
                      itemBuilder: (ctx, index) => SharedItemWidget(
                        model: NavigationModel(
                          name: provider.sections[index].title,
                          image: AppImages.folder,
                          index: index,
                          onTap: isloading == true
                                ? () {
                             setState(() {
                                            isloading = false;
                                          });
                            _showSnackbar(
                              context,
                              'Please Wait..!',
                            );
                            checkSection(provider.sections[index].id);
                            Future.delayed(Duration(seconds: 2), () async {
                              if (isActive == true) {
                                if (provider.sections[index].haveSections) {
                                  context.push(
                                    BooksSubSectionsScreen(
                                      id: provider.sections[index].id,
                                    ),
                                  );
                                  isActive = false;
                                } else {
                                  context.push(
                                    BooksScreen(
                                      id: provider.sections[index].id,
                                    ),
                                  );
                                   setState(() {
                                            isloading = true;
                                          });
                                  isActive = false;
                                }
                              } else {
                                _showSnackbar(
                                  context,
                                  'This Section dont allow for you!',
                                );
                                 setState(() {
                                            isloading = true;
                                          });
                              }
                            });
                          }:null,
                        ),
                      ),
                      separatorBuilder: (ctx, index) => const SizedBox(
                        height: 25,
                      ),
                      itemCount: provider.sections.length,
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
    );
  }
}
