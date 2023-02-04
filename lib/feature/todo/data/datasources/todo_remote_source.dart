import 'dart:convert';

import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

abstract class TodoRemoteSource {
  // This should be in there own repo, usecase and other stuff
  // This is just for test purposes
  Future<void> getAuthToken();

  Future<dynamic> getCategories();

  Future<List<TodoNetwork>> getTodo(String timestamp);

  Future<dynamic> addTodo();

  Future<void> updateTodo(
    String documentId, {
    String? date,
    String? categoryId,
    String? name,
    bool? isCompleted,
  });
}

class TodoEndpoints {
  // again this should be in there own repo
  // Repo that contains all auth related operations
  static const _todoBaseUrl =
      'https://firestore.googleapis.com/v1/projects/applaudo-todo-app/databases/(default)/documents';

  static const loginWithCredential =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
  static const todoQuery = '$_todoBaseUrl:runQuery';
  static const addTodo = '$_todoBaseUrl/task';
}

class TodoRemoteSourceImpl implements TodoRemoteSource {
  TodoRemoteSourceImpl({
    required this.dioService,
  });

  final DioService dioService;

  @override
  Future addTodo() async {
    final data = {
      "fields": {
        "date": {"integerValue": "1664072803"},
        "categoryId": {"stringValue": "DDQeCPpZATcLfV9U3I0v"},
        "name": {"stringValue": "testing"},
        "isCompleted": {"booleanValue": false}
      }
    };

    try {
      final queryParams = {'key': firebaseApiKey};
      final response = await dioService.post(TodoEndpoints.addTodo,
          queryParameters: queryParams, data: data);
      final responseMap = (response.data as Map<String, dynamic>);
      return TodoNetwork.fromJson(responseMap);
    } catch (e, s) {
      throw ServerException();
    }
  }

  @override
  Future<void> getAuthToken() async {
    try {
      final data = {
        "email": "test@test.com",
        "password": "password",
        "returnSecureToken": true
      };

      final queryParams = {'key': firebaseApiKey};

      final response = await dioService.post(
        TodoEndpoints.loginWithCredential,
        queryParameters: queryParams,
        data: data,
      );
      final accessToken = (response.data as Map)['idToken'];
      // set custom token our data source
      dioService.dioDataSource.setAccessToken(accessToken);
    } catch (e, s) {
      print(s);
      throw ServerException();
    }
  }

  @override
  Future getCategories() {
    throw UnimplementedError();
  }

  @override
  Future<List<TodoNetwork>> getTodo(String timestamp) async {
    try {
      final queryBody = {
        "structuredQuery": {
          "from": [
            {"collectionId": "tasks"}
          ],
          "where": {
            "fieldFilter": {
              "field": {"fieldPath": "date"},
              "op": "GREATER_THAN_OR_EQUAL",
              "value": {"stringValue": timestamp}
            }
          },
          "select": {
            "fields": [
              {"fieldPath": "categoryId"},
              {"fieldPath": "id"},
              {"fieldPath": "name"},
              {"fieldPath": "date"},
              {"fieldPath": "isCompleted"}
            ]
          }
        }
      };

      final queryParams = {'key': firebaseApiKey};
      final response = await dioService.post(TodoEndpoints.todoQuery,
          queryParameters: queryParams, data: queryBody);
      return todoFromJson(jsonEncode(response.data));
    } catch (e, s) {
      print(s);
      throw ServerException();
    }
  }

  @override
  Future<void> updateTodo(
    String documentId, {
    String? date,
    String? categoryId,
    String? name,
    bool? isCompleted,
  }) async {
    final updateEndpoint = "${TodoEndpoints.addTodo}/$documentId";
    final data = {
      "fields": {
        if (date != null) "date": {"integerValue": "1664072803"},
        if (categoryId != null)
          "categoryId": {"stringValue": "DDQeCPpZATcLfV9U3I0v"},
        if (name != null) "name": {"stringValue": "testing"},
        if (isCompleted != null) "isCompleted": {"booleanValue": false}
      }
    };

    try {
      final queryParams = {'key': firebaseApiKey};

      final response = await dioService.post(updateEndpoint,
          queryParameters: queryParams, data: data);
      final responseMap = (response.data as Map<String, dynamic>);
      // return TodoNetwork.fromJson(responseMap);
    } catch (e, s) {
      throw ServerException();
    }
  }
}
