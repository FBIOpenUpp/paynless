import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg.replaceFirst('Exception:', ''),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    textColor: (Colors.black),
    backgroundColor: (Colors.grey),
    fontSize: 12.0,
  );
}
