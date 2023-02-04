import 'package:todo_sample_app/feature/todo/domain/repositories/todo_repositorie.dart';

class TodoUseCase {
  final TodoRepository _todoRepository;

  TodoUseCase(this._todoRepository);

  Future<void> getAuthToken() {
    return _todoRepository.getAuthToken();
  }
}
