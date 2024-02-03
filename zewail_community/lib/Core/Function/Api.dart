import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  final Dio dio;

  Apiservice(this.dio);

  Future<Map<String, dynamic>> getdio(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    var resposne = await dio.get(url, queryParameters: queryParameters);
    return resposne.data;
  }

  Future<Map<String, dynamic>> postdio(
      {required String url,
      Map<String, dynamic>? queryParameters,
      required Map<String, dynamic> data}) async {
    var resposne =
        await dio.post(url, queryParameters: queryParameters, data: data);
    return resposne.data;
  }

  Future<Map<String, dynamic>> postdiofromdata(
      {required String url,
      Map<String, dynamic>? queryParameters,
      required dynamic data}) async {
    var resposne =
        await dio.post(url, queryParameters: queryParameters, data: data);
    return resposne.data;
  }
}

class Api {
  Future<dynamic> get({
    required String url,
  }) async {
    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post({
    required String url,
    required Map body,
  }) async {
    // Map<String, String> headers = {};

    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
// }
    var response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    print('url = $url body = $body token = $token ');
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
