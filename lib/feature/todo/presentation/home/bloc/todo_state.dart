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
  final List<Todos> completedTodos;
  final List<Todos> inCompletedTodos;

  const TodoLoaded(this.completedTodos, this.inCompletedTodos);

  @override
  List<Object> get props => [completedTodos, inCompletedTodos];
}

class TodoFailure extends TodoState {
  final String message;

  TodoFailure(this.message);

  @override
  List<Object> get props => [message];
}
