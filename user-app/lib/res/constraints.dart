// api : auth

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

String baseUrl = "https://api-paynless.onrender.com";

//heights and widths
final width = MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width;
final height = MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height;

//time diff
getTimeDifference(String time) {
  final date2 = DateTime.now();

  DateTime receivedDate = DateTime.parse(time).toLocal();
  int year = receivedDate.year;
  int month = receivedDate.month;
  int day = receivedDate.day;
  int hour = receivedDate.hour;
  int minute = receivedDate.minute;
  int second = receivedDate.second;

  if (date2.day - day >= 1) {
    return "${date2.day - day}d ago";
  } else if (date2.day - day >= 7) {
    return "${(date2.day - day) % 7}w ago";
  } else if (date2.month - month >= 1) {
    return "${(date2.month - month)}mon ago";
  } else if (date2.year - year >= 1) {
    return "${(date2.year - year)}y ago";
  } else if (date2.hour - hour >= 1) {
    return "${(date2.hour - hour)}h ago";
  } else if (date2.minute - minute >= 1) {
    return "${(date2.minute - minute)}m ago";
  } else if (date2.second - second >= 1) {
    return "${(date2.second - second)}s ago";
  } else {
    return "just now";
  }
}

String getTimeDifferenceWithoutData(DateTime date, {required bool showDay}) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final now = DateTime.now();
  if (formatter.format(now) == formatter.format(date.toLocal())) {
    // show time
    return showDay
        ? 'Today ${DateFormat('jm').format(date.toLocal())}'
        : DateFormat('jm').format(date.toLocal());
  } else if (formatter.format(DateTime(now.year, now.month, now.day - 1)) ==
      formatter.format(date)) {
    return 'Yesterday';
  } else {
    return '${DateFormat('d').format(date.toLocal())} ${DateFormat('MMMM').format(date.toLocal())} ${DateFormat('y').format(date.toLocal()).substring(2)}';
  }
}

//api : auth
const String googleAuthApi = "/api/v1/oauth/";
const String getUserDataApi = "/api/v1/oauth/profile/";
