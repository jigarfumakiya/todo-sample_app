import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoUseCase _todoUseCase;

  TodoCubit(this._todoUseCase) : super(TodoInitial());

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

  Future<void> getTodosFromNetwork() async {
    emit(TodoLoading());
    try {
      final todos = await _todoUseCase.getTodos();
      todos.fold((failure) {
        emit(TodoFailure('Unable to load todos'));
      }, (data) {
        emit(TodoLoaded(data.documents));
      });
    } catch (e, s) {
      emit(TodoFailure('Unable to load todos'));
    }
  }
}
