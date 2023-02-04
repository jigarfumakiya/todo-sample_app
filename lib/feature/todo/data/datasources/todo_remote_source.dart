import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

abstract class TodoRemoteSource {
  // This should be in there own repo, usecase and other stuff
  // This is just for test purposes
  Future<void> getAuthToken();

  Future<dynamic> getCategories();

  Future<TodoNetwork> getTodo();

  Future<dynamic> addTodo();
}

class TodoEndpoints {
  // again this should be in there own repo
  // Repo that contains all auth related operations
  static const _todoBaseUrl =
      'https://firestore.googleapis.com/v1/projects/applaudo-todo-app/databases/(default)/documents';

  static const loginWithCredential =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
  static const getTodo = '$_todoBaseUrl/tasks';
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
      final response = await dioService.post(TodoEndpoints.getTodo,
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
      throw ServerException();
    }
  }

  @override
  Future getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<TodoNetwork> getTodo() async {
    try {
      final queryParams = {'key': firebaseApiKey};
      final response = await dioService.get(
        TodoEndpoints.getTodo,
        queryParameters: queryParams,
      );
      final responseMap = (response.data as Map<String, dynamic>);
      return TodoNetwork.fromJson(responseMap);
    } catch (e, s) {
      throw ServerException();
    }
  }
}
