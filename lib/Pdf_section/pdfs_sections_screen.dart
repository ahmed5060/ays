import 'dart:io';

import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/helper/api_helper.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/views/pdf/pdf_viewer_widget.dart';
import 'package:flutter/material.dart';

class PdfSectionsScreen extends StatefulWidget {
  const PdfSectionsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<PdfSectionsScreen> createState() => _PdfSectionsScreenState();
}

bool isActive = false;
String title = "";
String pdf = "";
List isData = [];

Future<void> getPdfs(int courseId) async {
  final response = await APIHelper.apiCall(
    type: APICallType.get,
    url: '${EndPoints.pdfsSection}$courseId',
  );

  if (response.success) {
    if (response.data != null && response.data['data'] != null) {
      List responseData = response.data['data'];
      if (responseData.isNotEmpty) {
        title = responseData[0]["title"];
        pdf = responseData[0]["pdf"];
        isData = responseData;
        // print(isData);
        // print(title);
        // print(pdf);
      }
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

class _PdfSectionsScreenState extends State<PdfSectionsScreen> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    try {
      await getPdfs(widget.id);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        title: title,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: FutureBuilder(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingWidget(); // Show loading widget
            } else if (snapshot.hasError || title.isEmpty || pdf.isEmpty) {
              return EmptyWidget(); // Show empty widget or error message
            } else {
              return Row(
                mainAxisAlignment: Platform.isWindows
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to PDF viewer
                      context.push(
                        PdfViewerWidget(
                          url: pdf,
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 30.appHeight(context),
                      width: Platform.isWindows
                          ? 50.appWidth(context)
                          : 100.appWidth(context) - 40,
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Image.asset(
                              AppImages.testBook2,
                              scale: 1.2,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(),
                                const SizedBox(),
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: AppColors.blueColor1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppFonts.font22,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.calenderGrey,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                                      style: const TextStyle(
                                        color: AppColors.greyColor1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: AppFonts.font12,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.blueColor1,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Open Pdf',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: AppFonts.font12,
                                        ),
                                      ),
                                      SizedBox(),
                                      Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.whiteColor,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(),
                                const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
