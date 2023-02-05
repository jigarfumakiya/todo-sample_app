import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

import '../../../../../core/app/app_constant.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final TodoUseCase _todoUseCase;

  AddTodoCubit(this._todoUseCase) : super(AddTodoInitial());

  Future<void> addTodo(Fields fields) async {
    emit(const AddTodoLoading());
    try {
      final todos = await _todoUseCase.addTodos(fields);
      todos.fold((failure) {
        emit(TodoAddingFailed(failure.message));
      }, (data) {
        emit(const AddTodoAdded('Todo Status updated successfully'));
      });
    } catch (e, s) {
      emit(const TodoAddingFailed(addTodoFailedMessage));
    }
  }
}
