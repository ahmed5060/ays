import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/response_model.dart';
import '../utils/exceptions.dart';
import 'app_helper.dart';

class APIHelper {
  static Future<http.Response> _getMethod(String url) async {
    Map<String, String> headers = AppHelper.getHeader();
    http.Response response = await http.get(
      Uri.parse(
        url,
      ),
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> _postMethod(
      String url, dynamic bodyMethod, bool authHeader) async {
    debugPrint(bodyMethod.toString());
    Map<String, String> headers =
        authHeader ? AppHelper.getAuthHeader() : AppHelper.getHeader();
    http.Response response = await http.post(
      Uri.parse(
        url,
      ),
      headers: headers,
      body: json.encode(
        bodyMethod,
      ),
    );
    return response;
  }

  static Future<http.Response> _postImageMethod(
      String url, dynamic bodyMethod) async {
    Map<String, String> headers = AppHelper.getHeader();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
        bodyMethod.keys.first,
        bodyMethod.values.first,
      ),
    );
    bodyMethod.remove(bodyMethod.keys.first);

    bodyMethod.forEach((key, value) {
      request.fields[key] = value;
    });

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  static Future<http.Response> _putMethod(
      String url, dynamic bodyMethod) async {
    Map<String, String> headers = AppHelper.getHeader();
    http.Response response = await http.put(
      Uri.parse(
        url,
      ),
      headers: headers,
      body: json.encode(
        bodyMethod,
      ),
    );
    return response;
  }

  static Future<http.Response> _deleteMethod(
      String url, dynamic bodyMethod) async {
    Map<String, String> headers = AppHelper.getHeader();
    http.Response response = await http.delete(
      Uri.parse(
        url,
      ),
      headers: headers,
      body: json.encode(
        bodyMethod,
      ),
    );
    return response;
  }

  static Future<ResponseModel> apiCall({
    required APICallType type,
    required String url,
    dynamic apiBody = const {},
    bool isMain = true,
    bool authHeader = false,
  }) async {
    try {
      late http.Response response;
      if (type == APICallType.get) {
        response = await _getMethod(url);
      } else if (type == APICallType.post) {
        response = await _postMethod(url, apiBody, authHeader);
      } else if (type == APICallType.put) {
        response = await _putMethod(url, apiBody);
      } else if (type == APICallType.delete) {
        response = await _deleteMethod(url, apiBody);
      } else if (type == APICallType.postImage) {
        response = await _postImageMethod(url, apiBody);
      }
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(
          message: '',
          success: true,
          data: body,
        );
      } else if (response.statusCode == 440) {
        if (isMain) {
          Exceptions.updateException();
        }
      } else if (response.statusCode == 401) {
        if (isMain) {
          Exceptions.unAuthException();
        }
      } else {
        if (isMain) {
          Exceptions.unExpectedException(
            body['message'] ?? '',
          );
        }
      }
      return ResponseModel(
        message: '',
        success: false,
        data: null,
      );
    } on SocketException {
      if (isMain) {
        Exceptions.networkException();
      }
      return ResponseModel(
        message: '',
        success: false,
        data: null,
      );
    } catch (e) {
      //debugPrint(e.toString());
      if (isMain) {
        Exceptions.unExpectedException();
      }
      return ResponseModel(
        message: '',
        success: false,
        data: null,
      );
    }
  }
}

enum APICallType {
  get,
  post,
  postImage,
  put,
  delete,
}
