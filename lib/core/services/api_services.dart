import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../errors/server_failure.dart';

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
}
