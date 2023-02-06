import 'dart:convert';

import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

abstract class TodoRemoteSource {
  // This should be in there own repo, usescases and other stuff
  // This is just for test purposes
  Future<String> getAuthToken();

  Future<dynamic> getCategories();

  Future<List<TodoNetwork>> getTodo(String timestamp);

  Future<Document> addTodo(Fields fields);

  Future<Document> updateTodo(String documentId, Fields fields);
}

class TodoEndpoints {
  // again this should be in there own repo
  // Repo that contains all auth related operations
  static const _todoBaseUrl =
      'https://firestore.googleapis.com/v1/projects/applaudo-todo-app/databases/(default)/documents';

  static const loginWithCredential =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
  static const todoQuery = '$_todoBaseUrl:runQuery';
  static const addTodo = '$_todoBaseUrl/tasks';
  static const updateTodo = '$_todoBaseUrl';
}

class TodoRemoteSourceImpl implements TodoRemoteSource {
  TodoRemoteSourceImpl({
    required this.dioService,
  });

  final DioService dioService;

  @override
  Future<Document> addTodo(Fields fields) async {
    try {
      final queryParams = {'key': firebaseApiKey};
      final response = await dioService.post(TodoEndpoints.addTodo,
          queryParameters: queryParams, data: fields.toJson());
      final responseMap = (response.data as Map<String, dynamic>);
      return Document.fromJson(responseMap);
    } catch (e, s) {
      print(s);
      // We can generic error handling classes
      throw ServerException(addTodoFailedMessage);
    }
  }

  @override
  Future<String> getAuthToken() async {
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
      return accessToken;
    } catch (e, s) {
      print(s);
      throw ServerException(authFailedMessage);
    }
  }

  @override
  Future getCategories() {
    throw UnimplementedError();
  }

  @override
  Future<List<TodoNetwork>> getTodo(String timestamp) async {
    print('Selected timestamp: $timestamp');
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
      throw ServerException(todoFailedMessage);
    }
  }

  @override
  Future<Document> updateTodo(
    String documentId,
    Fields fields,
  ) async {
    final updateEndpoint = "${TodoEndpoints.addTodo}/$documentId";
    try {
      final queryParams = {'key': firebaseApiKey};

      final response = await dioService.patch(updateEndpoint,
          queryParameters: queryParams, data: fields.toJson());
      final responseMap = (response.data as Map<String, dynamic>);
      return Document.fromJson(responseMap);
    } catch (e, s) {
      throw ServerException(updateTodoFailedMessage);
    }
  }
}
