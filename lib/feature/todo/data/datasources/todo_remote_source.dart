import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';

abstract class TodoRemoteSource {
  // This should be in there own repo, usecase and other stuff
  // This is just for test purposes
  Future<void> getAuthToken();

  Future<dynamic> getCategories();

  Future<dynamic> getTodo();

  Future<dynamic> addTodo();
}

class TodoEndpoints {
  // again this should be in there own repo
  // Repo that contains all auth related operations
  static const loginWithCredential =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
}

class TodoRemoteSourceImpl implements TodoRemoteSource {
  TodoRemoteSourceImpl({
    required this.dioService,
  });

  final DioService dioService;

  @override
  Future addTodo() {
    // TODO: implement addTodo
    throw UnimplementedError();
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
  Future getTodo() {
    // TODO: implement getTodo
    throw UnimplementedError();
  }
}
