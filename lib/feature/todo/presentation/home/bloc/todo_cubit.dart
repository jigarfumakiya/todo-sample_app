import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoUseCase _todoUseCase;

  TodoCubit(this._todoUseCase) : super(TodoInitial());

  Future<void> auth() async {
    emit(AuthLoading());
    try {
      await _todoUseCase.getAuthToken();
      emit(AuthCompleted());
    } catch (e, s) {
      emit(AuthFailed());
    }
  }
}
