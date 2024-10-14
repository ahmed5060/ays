import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../utils/app_constants.dart';
import '../utils/exceptions.dart';

class AppHelper {
  static Future<void> copy(String text) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    Exceptions.success(
      'Copied',
    );
  }

  static Future<void> launchToGoogle(String url) async {
    await launchUrl(
      Uri.parse(
        url,
      ),
    );
  }

  static DateTime setDateFormat() {
    return DateTime.now();
  }

  static Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Map getUserModel() {
    return Hive.box(AppConstants.myBox).get(
      AppConstants.userDataKey,
      defaultValue: {},
    );
  }

  static int getUserId() {
    return Hive.box(AppConstants.myBox).get(
      AppConstants.userIdKey,
      defaultValue: 0,
    );
  }

  static String getToken() {
    return 'Bearer ${Hive.box(AppConstants.myBox).get(
      AppConstants.tokenKey,
      defaultValue: '',
    )}';
  }

  static Map<String, String> getAuthHeader() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  static Map<String, String> getHeader() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": AppHelper.getToken(),
    };
  }

  static Future<Uint8List?> loadPDF(String url) async {
    try {
      var data = await http.get(
        Uri.parse(url),
      );
      // print(data.body);
      return data.bodyBytes;
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String> getDeviceId() async {
    String id = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.id; // unique ID on Android
    } else if (Platform.isWindows) {
      var windowsDeviceInfo = await deviceInfo.windowsInfo;
      id = windowsDeviceInfo.deviceId;
    }
    debugPrint(id);
    return id;
  }

  static String setDateFormatFromMe(DateTime time) {
    final d = DateTime.now().difference(time);
    var format = d >= const Duration(days: 1)
        ? DateFormat.yMd('ar')
        : DateFormat.Hms('ar');
    return format.format(time);
  }

  static String setNumbers(num number) {
    if (number >= 1000000) {
      return '${number / 1000000} M';
    } else if (number >= 1000) {
      return '${number / 1000} K';
    }

    return number.toString();
  }
}
