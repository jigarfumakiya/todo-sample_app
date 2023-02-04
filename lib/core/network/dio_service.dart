import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_sample_app/core/network/dio_data_source.dart';
import 'package:todo_sample_app/core/network/refresh_token_usecase.dart';

class DioService {
  final DioDataSource dioDataSource;
  final RefreshTokenUseCase refreshTokenUseCase;

  DioService({required this.dioDataSource, required this.refreshTokenUseCase});

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dioDataSource.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } catch (error) {
      if (error is DioError &&
          error.response != null &&
          error.response!.statusCode == 401) {
        /** We are keeping getting in loop
            reason being we are calling same for refresh token and login
            If user on login and token expired we will call same api again
            and keeps getting in loop*/

        // Token has expired
        // Remove the token so we can avoid using old token
        dioDataSource.setAccessToken('');
        final response = await refreshTokenUseCase.execute();
        dioDataSource
            .setAccessToken(await refreshTokenUseCase.getAccessToken());
        // we need to check this because we are using same endpoint
        // this should be different endpoint
        if (RefreshEndpoint.refreshEndpoint == uri) {
          // if login the api try to refresh the token
          return response;
        }

        return get(uri,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress);
      } else {
        rethrow;
      }
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dioDataSource.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (error) {
      if (error is DioError &&
          error.response != null &&
          error.response!.statusCode == 401) {
        /** We are keeping getting in loop
            reason being we are calling same for refresh token and login
            If user on login and token expired we will call same api again
            and keeps getting in loop*/

        // Token has expired
        // Remove the token so we can avoid using old token
        dioDataSource.setAccessToken('');
        final response = await refreshTokenUseCase.execute();
        dioDataSource
            .setAccessToken(await refreshTokenUseCase.getAccessToken());
        // we need to check this because we are using same endpoint
        // this should be different endpoint
        if (RefreshEndpoint.refreshEndpoint == uri) {
          // if login the api try to refresh the token
          return response;
        }

        return post(uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
      } else {
        rethrow;
      }
    }
  }
}
