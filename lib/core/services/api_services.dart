import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../errors/server_failure.dart';
import '../utils/app_strings.dart';

class ApiServices {
  final Dio _dio;

  ApiServices(this._dio);

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: {
          ...?queryParameters,
          'apiKey': dotenv.env['API_KEY'],
        },
      );
      if (response.statusCode != 200) {
        throw handleServerError(response.data);
      }
      return response.data;
    } catch (e) {
      throw handleServerError(e);
    }
  }

  // setup Dio
  static Dio setupDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: AppStrings.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      logPrint: (Object object) {
        debugPrint(object.toString());
      },
    ));

    // InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     // Do something before the request is sent
    //     // For example, add authentication headers
    //     options.headers['Authorization'] = 'Bearer YourAuthToken';
    //
    //     return handler.next(options); // continue with the request
    //   },
    //   onResponse: (response, handler) {
    //     // Do something with the response
    //     // For example, logging or error handling
    //     debugPrint('Response: ${response.data}');
    //
    //     return handler.next(response); // continue with the response
    //   },
    //   onError: (DioException e, handler) {
    //     // Do something with the error
    //     // For example, logging or custom error handling
    //     debugPrint('Error: ${e.message}');
    //
    //     return handler.next(e); // continue with the error
    //   },
    // );

    return dio;
  }
}
