import 'package:dio/dio.dart';

import 'api_constants.dart';

class ApiManager {
  ApiManager({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: ApiConstants.connectTimeout,
                receiveTimeout: ApiConstants.receiveTimeout,
              ),
            );

  final Dio dio;
}
