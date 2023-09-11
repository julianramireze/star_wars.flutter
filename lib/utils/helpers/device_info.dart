import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  Future<String> getVersionApp() async {
    PackageInfo appInfo = await PackageInfo.fromPlatform();
    return appInfo.version;
  }
}
