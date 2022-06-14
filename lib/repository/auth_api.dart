import 'dart:io';

import 'package:dio/dio.dart';
import 'package:education_app/constant/api_url.dart';

class AuthApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        "x-api-key": ApiUrl.apiKey,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      responseType: ResponseType.json,
    );
    final dio = Dio(options);
    return dio;
  }

  Future<Map<String, dynamic>?> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        print("error timeout");
      }
      print("error dio");
    } catch (e) {
      print("error lainnya");
    }
  }

  Future<Map<String, dynamic>?> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, data: body);
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        print("error timeout");
      }
      print("error dio");
    } catch (e) {
      print("error lainnya");
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(email) async {
    final result =
        await _getRequest(endpoint: ApiUrl.users, param: {"email": email});
    return result;
  }
}
