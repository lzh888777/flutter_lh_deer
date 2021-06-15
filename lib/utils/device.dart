import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_lh_deer/res/constant.dart';

class Device {
  static bool get isWeb => kIsWeb;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isIOS => !isWeb && Platform.isIOS;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isFushsia => !isWeb && Platform.isFuchsia;
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static late AndroidDeviceInfo _androidInfo;

  static Future<void> initDeviceInfo() async {
    if (isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      _androidInfo = await deviceInfo.androidInfo;
    }
  }

  static int getAndroidSDKInt() {
    if (Constant.isDriverTest) {
      return -1;
    }

    if (isAndroid && _androidInfo != null) {
      return _androidInfo.version.sdkInt ?? -1;
    } else {
      return -1;
    }
  }
}
