part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class AuthFailed extends TodoState {
  final String cause;

  AuthFailed(this.cause);

  @override
  List<Object> get props => [];
}

class AuthCompleted extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final List<TodoNetwork> completedTodos;
  final List<TodoNetwork> inCompletedTodos;

  const TodoLoaded(this.completedTodos, this.inCompletedTodos);

  @override
  List<Object> get props => [completedTodos, inCompletedTodos];
}

class TodosUpdated extends TodoState {
  final List<TodoNetwork> completedTodos;
  final List<TodoNetwork> inCompletedTodos;

  const TodosUpdated(this.completedTodos, this.inCompletedTodos);

  @override
  List<Object> get props => [completedTodos, inCompletedTodos];
}

class TodoFailure extends TodoState {
  final String message;

  TodoFailure(this.message);

  @override
  List<Object> get props => [message];
}

class TodoUpdatedMessage extends TodoState {
  final String message;

  TodoUpdatedMessage(this.message);

  @override
  List<Object> get props => [message];
}
