import 'package:dio/dio.dart';
import 'package:todo_sample_app/core/app/storage_utils.dart';

abstract class DioDataSource {
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<void> setAccessToken(String accessToken);

  Future<void> clearToken();
}

class DioDataSourceImpl implements DioDataSource {
  final Dio _dio;
  String? _accessToken;

  DioDataSourceImpl(this._dio, [bool isMock = false]) {
    if (!isMock) {
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null && _accessToken != '') {
            options.headers["Authorization"] = "Bearer $_accessToken";
          }
          handler.next(options);
        },
      ));
    }
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    _accessToken = accessToken;
  }

  @override
  Future<Response> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> patch(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> clearToken() {
    return SecureStorage.clearKey(SecureStorage.accessToken);
  }

// @override
// Future<Response> request(String method, String uri,
//     {data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress}) async {
//   try {
//     var response = await _dio.request(
//       method,
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//     );
//     return response;
//   } catch (error) {
//     rethrow;
//   }
// }
}
