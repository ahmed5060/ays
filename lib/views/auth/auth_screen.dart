import 'dart:io';

import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_fonts.dart';
import '../../models/category_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).getMainCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, provider, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: provider.authFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Image.asset(
                          AppImages.appLogo,
                          height: 120,
                        ),
                        const Text(
                          'Welcome to AYS Academy',
                          style: TextStyle(
                            color: AppColors.blueColor1,
                            fontSize: AppFonts.font22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        for (int index = 0;
                            index <
                                (provider.isLogin
                                    ? provider.loginData.length
                                    : provider.registerData.length);
                            index++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.isLogin
                                    ? provider.loginData[index]
                                    : provider.registerData[index],
                                style: const TextStyle(
                                  color: AppColors.blueColor1,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // if (index ==
                              //     2) // Check for the 'Student Code' field
                              //   TextFormField(
                              //     obscureText: false,
                              //     controller: provider
                              //         .codeController, // Use a controller for the student code
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return 'This field must not be empty';
                              //       }
                              //       // Add additional validation if needed
                              //       return null;
                              //     },
                              //     onTap: () async {},
                              //     decoration: InputDecoration(
                              //       hintText:
                              //           "Enter ${provider.isLogin ? provider.loginData[index] : provider.registerData[index]}",
                              //       border: const OutlineInputBorder(),
                              //       focusedBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           color: AppColors.blueColor1,
                              //         ),
                              //       ),
                              //       enabledBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           color: AppColors.blueColor1,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
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
                                  items: (provider.mainSelectedCategory !=
                                                  null &&
                                              provider.supCategories[provider
                                                      .mainSelectedCategory!
                                                      .id] !=
                                                  null
                                          ? provider.supCategories[provider
                                              .mainSelectedCategory!.id]!
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
                                  obscureText:
                                      (provider.isLogin && index == 1 ||
                                              index == 6)
                                          ? !provider.showPassword
                                          : index == 7
                                              ? !provider.showConfirmPassword
                                              : false,
                                  controller: provider.isLogin
                                      ? index == 0
                                          ? provider.emailController
                                          : provider.passwordController
                                      : index == 0
                                          ? provider.nameController
                                          : index == 1
                                              ? provider.emailController
                                              : index == 2
                                                  ? provider.codeController
                                                  : index == 3
                                                      ? provider.phoneController
                                                      : index == 7
                                                          ? provider
                                                              .passwordController
                                                          : provider
                                                              .confirmPasswordController,
                                  validator: (value) {
                                    if (index == 7) {
                                      if (value !=
                                          provider.passwordController.text) {
                                        return 'Confirm password does not equal password.';
                                      }
                                    }

                                    if (value == null || value.isEmpty) {
                                      return 'This field must not be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () async {},
                                  decoration: InputDecoration(
                                    hintText:
                                        "Enter ${provider.isLogin ? provider.loginData[index] : provider.registerData[index]}",
                                    border: const OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.blueColor1,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.blueColor1,
                                      ),
                                    ),
                                    suffixIcon: provider.isLogin
                                        ? index == 1
                                            ? InkWell(
                                                onTap: () {
                                                  provider.changeShowPassword();
                                                },
                                                child: Icon(
                                                  provider.showPassword
                                                      ? Icons
                                                          .visibility_off_outlined
                                                      : Icons
                                                          .visibility_outlined,
                                                ),
                                              )
                                            : null
                                        : index == 6
                                            ? InkWell(
                                                onTap: () {
                                                  provider.changeShowPassword();
                                                },
                                                child: Icon(
                                                  provider.showPassword
                                                      ? Icons
                                                          .visibility_off_outlined
                                                      : Icons
                                                          .visibility_outlined,
                                                ),
                                              )
                                            : index == 7
                                                ? InkWell(
                                                    onTap: () {
                                                      provider
                                                          .changeShowConfirmPassword();
                                                    },
                                                    child: Icon(
                                                      provider.showConfirmPassword
                                                          ? Icons
                                                              .visibility_off_outlined
                                                          : Icons
                                                              .visibility_outlined,
                                                    ),
                                                  )
                                                : null,
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
                          onTap: provider.authLoading
                              ? () {}
                              : () async {
                                  await provider.auth();
                                },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.blueColor1,
                            ),
                            child: provider.authLoading
                                ? const LoadingWidget(
                                    color: AppColors.whiteColor,
                                  )
                                : Text(
                                    provider.isLogin ? 'Login' : 'Signup',
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppFonts.font18,
                                    ),
                                  ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       provider.isLogin
                        //           ? 'Don’t have an account? '
                        //           : 'Already have an account? ',
                        //       style: const TextStyle(
                        //         color: AppColors.greyColor1,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: AppFonts.font15,
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         provider.changeIsLogin();
                        //       },
                        //       child: Text(
                        //         !provider.isLogin ? 'Login' : 'Signup',
                        //         style: const TextStyle(
                        //           color: AppColors.blueColor1,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: AppFonts.font15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                      ],
                    ),
                  ),
                  if (Platform.isWindows)
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          AppImages.appLogo,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
