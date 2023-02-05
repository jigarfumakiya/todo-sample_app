import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/extensions/strings.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

part 'todo_state.dart';

/** TodoCubit is a cubit class that manages the state of the todo app.
    This class uses TodoUseCase to get todos, authenticate and update todos.*/

class TodoCubit extends Cubit<TodoState> {
  final TodoUseCase _todoUseCase;

  TodoCubit(this._todoUseCase) : super(TodoInitial());

  // Two lists to store completed and incompleted todos

  List<TodoNetwork> completedTodos = [];
  List<TodoNetwork> inCompletedTodos = [];

  // Get auth token from firebase and set it to local
  Future<void> auth() async {
    emit(AuthLoading());
    try {
      await _todoUseCase.getAuthToken();
      // Emitting AuthCompleted state

      emit(AuthCompleted());
    } catch (e, s) {
      // Emitting AuthFailed state with message
      emit(AuthFailed(authFailedMessage));
    }
  }

  /// Method to get todos from network.
  ///
  /// [timeStamp] - a string representing the timeStamp of the todos to be fetched.
  ///
  /// Emits [TodoLoading] state while loading and [TodoLoaded] state on success with the completed
  /// and incompleted todos. In case of failure, [TodoFailure] state is emitted with the error message.
  Future<void> getTodosFromNetwork(String timeStamp) async {
    print('Selected Timestmp $timeStamp');
    emit(TodoLoading());
    try {
      final todos = await _todoUseCase.getTodos(timeStamp);
      todos.fold((failure) {
        emit(TodoFailure(failure.message));
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
      emit(TodoFailure(todoFailedMessage));
    }
  }

  Future<void> updateTodoAPI(String documentId, Fields fields) async {
    try {
      final todos = await _todoUseCase.updateTodos(documentId, fields);
      todos.fold((failure) {
        emit(TodoFailure(failure.message));
      }, (data) {
        emit(TodoUpdatedMessage('Todo Status updated successfully'));
      });
    } catch (e, s) {
      emit(TodoFailure(updateTodoFailedMessage));
    }
  }

  void updateTodoStatus(
    TodoNetwork updatedTodo,
    List<TodoNetwork> inCompleteList,
    List<TodoNetwork> completeList,
  ) async {
    emit(TodosUpdated(completeList, inCompleteList));

    updateTodoAPI(
        updatedTodo.document.name.toDocId(), updatedTodo.document.fields);
  }
}
