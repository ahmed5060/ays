import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () async {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).authCycle();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(
          AppImages.appLogo,
        ),
      ),
    );
  }
}
