import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';

class Pkg {
  static late String version;
  static void initPkg() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    log('version: ${packageInfo.version}');
    version = packageInfo.version;
  }
}
