import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoUseCase _todoUseCase;

  TodoCubit(this._todoUseCase) : super(TodoInitial());

  List<TodoNetwork> completedTodos = [];
  List<TodoNetwork> inCompletedTodos = [];

  // Get auth token from firebase and set it to local
  Future<void> auth() async {
    emit(AuthLoading());
    try {
      await _todoUseCase.getAuthToken();
      emit(AuthCompleted());
    } catch (e, s) {
      emit(AuthFailed());
    }
  }

  Future<void> getTodosFromNetwork(String timeStamp) async {
    emit(TodoLoading());
    try {
      final todos = await _todoUseCase.getTodos(timeStamp);
      todos.fold((failure) {
        emit(TodoFailure('Unable to load todos'));
      }, (data) {
        completedTodos = data
            .where(
                (element) => element.document.fields.isCompleted.booleanValue)
            .toList(growable: true);
        inCompletedTodos = data
            .where((element) =>
                element.document.fields.isCompleted.booleanValue == false)
            .toList(growable: true);
        emit(TodoLoaded(completedTodos, inCompletedTodos));
      });
    } catch (e, s) {
      emit(TodoFailure('Unable to load todos'));
    }
  }

  void updateTodoStatus(TodoNetwork todo) async {
    inCompletedTodos.remove(todo);
    final fields = todo.document.fields;

    final doc = todo.document.copyWith(
        fields: fields.copyWith(isCompleted: IsCompleted(booleanValue: true)));
    final updatedTodo = todo.copyWith(document: doc);
    completedTodos.add(updatedTodo);
    emit(TodoLoaded(completedTodos, inCompletedTodos));
  }

  void completeTodo() async {}
}
