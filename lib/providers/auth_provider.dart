import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/helper/app_helper.dart';
import 'package:courses_app/core/utils/app_constants.dart';
import 'package:courses_app/main.dart';
import 'package:courses_app/providers/courses_provider.dart';
import 'package:courses_app/views/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../core/endpoints/end_points.dart';
import '../core/helper/api_helper.dart';
import '../core/utils/exceptions.dart';
import '../models/category_model.dart';
import '../models/user_model.dart';
import '../views/courses/courses_screen.dart';

class AuthProvider extends ChangeNotifier {
  late UserModel userModel;

  Future<void> authCycle() async {
    final data = Hive.box(AppConstants.myBox).get(
      AppConstants.userDataKey,
      defaultValue: {},
    );
    if (data.isNotEmpty) {
      userModel = UserModel.fromJson(data);

      MyApp.navigatorKey.currentContext!.pushAndRemoveUtils(
        const CoursesScreen(),
      );
    } else {
      MyApp.navigatorKey.currentContext!.pushAndRemoveUtils(
        const AuthScreen(),
      );
    }
    notifyListeners();
  }

  bool isLogin = true;

  void changeIsLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  bool showPassword = false;

  void changeShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  bool showConfirmPassword = false;

  void changeShowConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  List<String> loginData = [
    'Email',
    'Password',
  ];
  List<String> registerData = [
    'Name',
    'Email',
    'Student Code',
    'Phone Number',
    'Category',
    'Sup Category',
    'Password',
    'Confirm Password', //7
  ];

  bool authLoading = false;
  CategoryModel? mainSelectedCategory;
  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];
  Map<int, List<CategoryModel>> supCategories = {};

  void changeMainSelectedCat(CategoryModel? model) async {
    mainSelectedCategory = model;
    notifyListeners();

    if (model != null) {
      await getSupCategories(model.id);
    }
  }

  void changeSelectedCat(CategoryModel? model) {
    selectedCategory = model;
    notifyListeners();
  }

  Future<void> auth() async {
    if (!authFormKey.currentState!.validate() ||
        (selectedCategory == null && !isLogin)) {
      return;
    }
    authLoading = true;
    notifyListeners();
    final response = await APIHelper.apiCall(
      authHeader: true,
      type: APICallType.post,
      url: isLogin ? EndPoints.login : EndPoints.register,
      apiBody: isLogin
          ? {
              "email": emailController.text,
              "password": passwordController.text,
              "mac_address": await AppHelper.getDeviceId(),
              "device_token": "123",
            }
          : {
              "name": nameController.text,
              "email": emailController.text,
              "password": passwordController.text,
              "phone": phoneController.text,
              "code": codeController.text,
              "cat_id": selectedCategory!.id,
              "mac_address": await AppHelper.getDeviceId(),
              "device_token": "123",
            },
    );

   if (response.success) {
      if (isLogin) {
        if (response.data['data'] != null &&
            response.data['data']['user_details'] != null) {
          userModel = UserModel.fromJson(response.data['data']['user_details']);

          await Hive.box(AppConstants.myBox).put(
            AppConstants.userDataKey,
            userModel.toJson(),
          );
          await Hive.box(AppConstants.myBox).put(
            AppConstants.userIdKey,
            userModel.id,
          );
          await Hive.box(AppConstants.myBox).put(
            AppConstants.tokenKey,
            response.data['data']['token'] ?? '',
          );
          Future.delayed(Duration.zero, () {
            MyApp.navigatorKey.currentContext!.pushAndRemoveUtils(
              const CoursesScreen(),
            );
          });
        }
      } else {
        isLogin = true;
      }
    }
    authLoading = false;
    notifyListeners();
  }


  void resetCats() {
    selectedCategory = null;
    mainSelectedCategory = null;
    categories = [];
    supCategories = {};
    notifyListeners();
  }

  bool updateLoading = false;

  Future<void> updateUserData() async {
    if (selectedCategory == null) {
      Exceptions.unExpectedException("You must select an category");
      return;
    }
    updateLoading = true;
    notifyListeners();
    final response = await APIHelper.apiCall(
      type: APICallType.put,
      url: EndPoints.updateUser,
      apiBody: {
        "name": userModel.name,
        "email": userModel.email,
        "phone": userModel.phone,
        "cat_id": selectedCategory!.id,
        "mac_address": await AppHelper.getDeviceId(),
        "device_token": "123"
      },
    );
    if (response.success) {
      MyApp.navigatorKey.currentContext!.pop();
      await MyApp.navigatorKey.currentContext!
          .read<CoursesProvider>()
          .getCourses();
    }
    updateLoading = false;

    notifyListeners();
  }

  Future<void> getMainCategories() async {
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: EndPoints.mainCategories,
    );
    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        categories = [];
        response.data['data'].forEach((item) {
          categories.add(
            CategoryModel.fromJson(
              item,
            ),
          );
        });
      }
    }
    notifyListeners();
  }

  Future<void> getSupCategories(int id) async {
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.supCategories}$id',
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        supCategories[id] = [];
        response.data['data'].forEach((item) {
          supCategories[id]!.add(
            CategoryModel.fromJson(
              item,
            ),
          );
        });
      }
    }
    notifyListeners();
  }
}
/*
{"success":true,"message":"User has been registered successfully","data":{"token":"7|0x5kYZAq1O3XJr0pqRjKFfqQxR0MZJbH1khh2SSS","user_details":,},}
 */
