import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart';

import '../../domain/repositories/todo_repositorie.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteSource remoteSource;

  TodoRepositoryImpl(this.remoteSource);

  @override
  Future addTodo() {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<void> getAuthToken() {
    // this methods will get token and save for later usecase
    return remoteSource.getAuthToken();
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
