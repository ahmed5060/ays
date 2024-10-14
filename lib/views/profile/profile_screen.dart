import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_constants.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/exceptions.dart';
import '../../main.dart';
import '../../models/category_model.dart';
import '../../providers/courses_provider.dart';
import '../start/start_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).resetCats();
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).getMainCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () async {
              context.pop();
              await context.read<CoursesProvider>().getCourses();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blueColor1,
            ),
          ),
          titleSpacing: 0,
          actions: [
            TextButton(
              onPressed: () async {
                await Hive.box(AppConstants.myBox).clear();
                Exceptions.unExpectedException(
                  'The account will be deleted in 3 days , if you login again , the process will be cancel.',
                );
                MyApp.navigatorKey.currentContext!.pushAndRemoveUtils(
                  const StartScreen(),
                );
              },
              child: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              // child: const Text(
              //   'Delete Account',
              //   style: TextStyle(
              //     color: AppColors.redColor,
              //     fontWeight: FontWeight.w600,
              //     fontSize: 15,
              //   ),
              // ),
            ),
          ],
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, _) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: Platform.isWindows ? 50 : 20,
              vertical: Platform.isWindows ? 30 : 15,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.testProfile,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              for (int index = 0; index < 6; index++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.registerData[index],
                      style: const TextStyle(
                        color: AppColors.blueColor1,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (index == 4)
                      DropdownButton<CategoryModel>(
                        value: provider.mainSelectedCategory,
                        isExpanded: true,
                        //icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(
                          color: AppColors.blueColor1,
                        ),
                        underline: Container(
                          height: 2,
                          color: AppColors.blueColor1,
                        ),
                        onChanged: (CategoryModel? value) {
                          provider.changeMainSelectedCat(value);
                        },
                        items: provider.categories
                            .map<DropdownMenuItem<CategoryModel>>(
                                (CategoryModel value) {
                          return DropdownMenuItem<CategoryModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    if (index == 5)
                      DropdownButton<CategoryModel>(
                        value: provider.selectedCategory,
                        isExpanded: true,
                        //icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(
                          color: AppColors.blueColor1,
                        ),
                        underline: Container(
                          height: 2,
                          color: AppColors.blueColor1,
                        ),
                        onChanged: (CategoryModel? value) {
                          provider.changeSelectedCat(value);
                        },
                        items: (provider.mainSelectedCategory != null &&
                                    provider.supCategories[provider
                                            .mainSelectedCategory!.id] !=
                                        null
                                ? provider.supCategories[
                                    provider.mainSelectedCategory!.id]!
                                : <CategoryModel>[])
                            .map<DropdownMenuItem<CategoryModel>>(
                                (CategoryModel value) {
                          return DropdownMenuItem<CategoryModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    if (index != 4 && index != 5)
                      TextFormField(
                        readOnly: true,
                        initialValue: index == 0
                            ? provider.userModel.name
                            : index == 1
                                ? provider.userModel.email
                                : index == 2
                                    ? provider.userModel.code
                                    : index == 3
                                        ? provider.userModel.phone
                                        : index == 4
                                            ? provider.userModel.nationality
                                            : index == 5
                                                ? provider.userModel.examDate
                                                : provider.userModel.speciality,
                        // controller: provider.isLogin
                        //     ? index == 0
                        //         ? provider.emailController
                        //         : provider.passwordController
                        //     : index == 0
                        //         ? provider.nameController
                        //         : index == 1
                        //             ? provider.emailController
                        //             : index == 2
                        //                 ? provider.phoneController
                        //                 : index == 3
                        //                     ? provider.passwordController
                        //                     : provider.confirmPasswordController,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.blueColor1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.blueColor1,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: provider.updateLoading
                    ? () {}
                    : () async {
                        await provider.updateUserData();
                      },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor1,
                  ),
                  child: provider.updateLoading
                      ? const CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        )
                      : const Text(
                          'Update',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: AppFonts.font18,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor1,
                  ),
                  child: const Text(
                    'Back To Courses',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.font18,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
