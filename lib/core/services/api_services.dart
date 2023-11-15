import 'package:dio/dio.dart';

import '../errors/server_error_handler.dart';

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
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      throw handleServerError(e);
    }
  }
}
