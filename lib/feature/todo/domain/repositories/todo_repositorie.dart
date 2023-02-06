import 'package:dartz/dartz.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

abstract class TodoRepository {
// this here just for test purpose
// Unless this should be in there own auth repo
  Future<Either<Failure, String>> getAuthToken();

  Future<dynamic> getCategories();

  Future<Either<Failure, List<TodoNetwork>>> getTodo(String timeStemp);

  Future<Either<Failure, Document>> addTodo(Fields fields);

  Future<Either<Failure, Document>> updateTodo(
      String documentId, Fields fields);
}
