// ignore_for_file: unused_field, unused_element

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../res/constraints.dart';
import '../res/toast.dart';

class HttpService {
  // final _baseUrl = 'http://127.0.0.1:1269/api/v1';
  final _baseUrl = baseUrl;

  late Response response;
  final _dio = Dio(BaseOptions(
    contentType: 'application/json',
    responseType: ResponseType.json,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  //functions for http handleing
  Future<Response> _get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      late Response res;
      debugPrint('${_baseUrl}$path $query');
      res = await _dio.request(_baseUrl + path,
          queryParameters: query,
          options: Options(method: 'GET', followRedirects: false));
      return res;
    } on SocketException {
      showToast('No Internet Connection');

      throw Exception('No Internet connection');
    } on FormatException {
      // showToast('Bad request');
      throw Exception('Bad request');
    } on Exception {
      // showToast('Something went wrong');
      throw Exception('Exception occured');
    } catch (e) {
      debugPrint(e.toString());

      throw e.toString();
    }
  }

  Future<Response> _post(
      {required String path,
      required dynamic body,
      Map<String, dynamic>? query}) async {
    try {
      late Response res;
      debugPrint('${_baseUrl}$path $query');
      res = await _dio.request(_baseUrl + path,
          queryParameters: query, data: body, options: Options(method: 'POST'));
      return res;
    } on SocketException {
      showToast('No Internet Connection');

      throw Exception('No Internet connection');
    } on FormatException {
      // showToast('Bad request');
      throw Exception('Bad request');
    } on Exception {
      // showToast('Something went wrong');
      throw Exception('Exception occured');
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<Response> _postWithHeader(
      {required String path,
      required dynamic body,
      Map<String, dynamic>? query,
      required String header}) async {
    try {
      late Response res;
      debugPrint('${_baseUrl}$path $query');
      res = await _dio.request(_baseUrl + path,
          data: body,
          queryParameters: query,
          options: Options(
              method: 'POST', headers: {'Authorization': "Bearer $header"}));
      return res;
    } on SocketException {
      showToast('No Internet Connection');
      throw Exception('No Internet connection');
    } on FormatException {
      // showToast('Bad request');
      throw Exception('Bad request');
    } on Exception {
      // showToast('Something went wrong');
      throw Exception('Exception occured');
    } catch (e) {
      debugPrint(e.toString());

      throw e.toString();
    }
  }

  Future<Response> _putWithHeader(
      {required String path,
      required dynamic body,
      required String header,
      Map<String, dynamic>? query}) async {
    try {
      late Response res;
      debugPrint('${_baseUrl}$path $query');
      res = await _dio.request(_baseUrl + path,
          data: body,
          queryParameters: query,
          options: Options(
              method: 'PUT', headers: {'Authorization': "Bearer $header"}));
      return res;
    } on SocketException {
      showToast('No Internet Connection');
      throw Exception('No Internet connection');
    } on FormatException {
      // showToast('Bad request');
      throw Exception('Bad request');
    } on Exception {
      // showToast('Something went wrong');
      throw Exception('Exception occured');
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<Response> _deleteWithHeader(
      {required String path,
      required dynamic body,
      required String header,
      Map<String, dynamic>? query}) async {
    try {
      late Response res;
      debugPrint('${_baseUrl}$path $query');
      res = await _dio.request(_baseUrl + path,
          data: body,
          queryParameters: query,
          options: Options(
              method: 'DELETE', headers: {'Authorization': "Bearer $header"}));
      return res;
    } on SocketException {
      showToast('No Internet Connection');
      throw Exception('No Internet connection');
    } on FormatException {
      // showToast('Bad request');
      throw Exception('Bad request');
    } on Exception {
      // showToast('Something went wrong');
      throw Exception('Exception occured');
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<Response> _getWithHeader(
      {required String path,
      required String header,
      Map<String, dynamic>? query}) async {
    try {
      late Response res;
      debugPrint('${_baseUrl}$path $query');
      res = await _dio.request(_baseUrl + path,
          queryParameters: query,
          options: Options(
              method: 'GET', headers: {'Authorization': "Bearer $header"}));
      return res;
    } on SocketException {
      showToast('No Internet Connection');
      throw Exception('No Internet connection');
    } on FormatException {
      // showToast('Bad request');
      throw Exception('Bad request');
    } on Exception {
      // showToast('Something went wrong');
      throw Exception('Exception occured');
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  //getters for class
  Future<Response> Function({required String path, Map<String, dynamic>? query})
      get get => _get;
  Future<Response> Function({
    required String header,
    required String path,
    Map<String, dynamic>? query,
  }) get getWithHeader => _getWithHeader;
  Future<Response> Function({required dynamic body, required String path})
      get post => _post;
  Future<Response> Function(
      {required dynamic body,
      required String header,
      Map<String, dynamic>? query,
      required String path}) get postWithHeader => _postWithHeader;
  Future<Response> Function(
      {required dynamic body,
      required String header,
      required String path,
      Map<String, dynamic>? query}) get putWithHeader => _putWithHeader;
  Future<Response> Function(
      {required dynamic body,
      required String header,
      required String path,
      Map<String, dynamic>? query}) get deleteWithHeader => _deleteWithHeader;
}
