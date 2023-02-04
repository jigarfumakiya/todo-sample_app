import 'package:dartz/dartz.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/repositories/todo_repositorie.dart';

class TodoUseCase {
  final TodoRepository _todoRepository;

  TodoUseCase(this._todoRepository);

  Future<void> getAuthToken() {
    return _todoRepository.getAuthToken();
  }

  // Get all todos form network
  Future<Either<Failure, List<TodoNetwork>>> getTodos(String timeStemp) {
    return _todoRepository.getTodo(timeStemp);
  }
}
