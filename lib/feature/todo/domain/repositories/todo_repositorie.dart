import 'package:dartz/dartz.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

abstract class TodoRepository {
// this here just for test purpose
// Unless this should be in there own auth repo
  Future<dynamic> getAuthToken();

  Future<dynamic> getCategories();

  Future<Either<Failure, TodoNetwork>> getTodo();

  Future<dynamic> addTodo();
}
