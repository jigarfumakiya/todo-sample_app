import 'package:dartz/dartz.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/repositories/todo_repositorie.dart';

/// `TodoUseCase` class is responsible for providing implementation
/// of business logic related to todos.
class TodoUseCase {
  final TodoRepository _todoRepository;

  TodoUseCase(this._todoRepository);

  /// This method will get authentication token from repository.
  Future<Either<Failure, String>> getAuthToken() {
    return _todoRepository.getAuthToken();
  }

  /// This method will get all todos from network.
  /// Returns [Either] instance containing [Failure] or list of [TodoNetwork].
  Future<Either<Failure, List<TodoNetwork>>> getTodos(String timeStemp) {
    return _todoRepository.getTodo(timeStemp);
  }

  /// This method will update todo in the network.
  /// Returns [Either] instance containing [Failure] or [Document].
  Future<Either<Failure, Document>> updateTodos(
      String documentId, Fields fields) {
    return _todoRepository.updateTodo(documentId, fields);
  }

  /// This method will add todo in the network.
  /// Returns [Either] instance containing [Failure] or [Document].
  Future<Either<Failure, Document>> addTodos(Fields fields) {
    return _todoRepository.addTodo(fields);
  }
}
