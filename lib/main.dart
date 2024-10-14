import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'core/helper/provider_helper.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_constants.dart';
import 'views/start/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(
      AppConstants.appName,
    );
    setWindowMaxSize(const Size(10000, 5000));
    setWindowMinSize(const Size(1100, 800));
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await Hive.initFlutter();
  await Hive.openBox(
    AppConstants.myBox,
  );
  runApp(
    MultiProvider(
      providers: ProviderHelper.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: AppColors.baseColor,
        primaryColor: AppColors.baseColor,
        scaffoldBackgroundColor: AppColors.whiteColor,
      ),
      home: const StartScreen(),
    );
  }
}
