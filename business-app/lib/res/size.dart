import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;

  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double safeAreaHorizontal;
  static late double safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double bodyHeight;
  static late double width;
  static late double height;

  static void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
    bodyHeight = mediaQueryData.size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    blockSizeHorizontal = width / 100;
    blockSizeVertical = bodyHeight / 100;

    safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (width - safeAreaHorizontal) / 100;
    safeBlockVertical = (bodyHeight - safeAreaVertical) / 100;
  }
}

Size screenSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return size;
}

bool isPortrait(BuildContext context) {
  var portrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return portrait;
}
