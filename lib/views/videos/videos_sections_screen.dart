import 'dart:io';

import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/helper/api_helper.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:courses_app/providers/navigation_provider.dart';
import 'package:courses_app/views/videos/videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/shared_item_widget.dart';
import '../../providers/videos_provider.dart';
import 'videos_sub_sections_widget.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

bool isActive = false;
bool isloading = true;
Future<void> checkSection(int id) async {
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
      duration: Duration(seconds: 2),
    ),
  );
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<VideosProvider>(context, listen: false).getSections(
        courseId: widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<VideosProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            MainAppBarWidget(
              title: 'Videos Section',
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

                                    Future.delayed(Duration(seconds: 2),
                                        () async {
                                      if (isActive == true) {
                                        if (provider
                                            .sections[index].haveSections) {
                                          context.push(
                                            VideosSubSectionsScreen(
                                              id: provider.sections[index].id,
                                            ),
                                          );
                                          setState(() {
                                            isloading = true;
                                          });
                                          isActive = false;
                                        } else {
                                          context.push(
                                            VideosScreen(
                                              id: provider.sections[index].id,
                                            ),
                                          );
                                          isActive = false;
                                          setState(() {
                                            isloading = true;
                                          });
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
                                  }
                                : null),
                      ),
                      separatorBuilder: (ctx, index) => const SizedBox(
                        height: 25,
                      ),
                      itemCount: provider.sections.length,
                    )
                  : Center(
                      child: provider.getVideosLoading
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
