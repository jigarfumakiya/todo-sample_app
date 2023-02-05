part of 'add_todo_cubit.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();
}

class AddTodoInitial extends AddTodoState {
  @override
  List<Object> get props => [];
}

class AddTodoAdded extends AddTodoState {
  final String message;

  const AddTodoAdded(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddTodoLoading extends AddTodoState {
  const AddTodoLoading();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TodoAddingFailed extends AddTodoState {
  final String message;

  const TodoAddingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
