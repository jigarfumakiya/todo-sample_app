import 'package:dartz/dartz.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

import '../../domain/repositories/todo_repositorie.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteSource remoteSource;

  TodoRepositoryImpl(this.remoteSource);

  @override
  Future addTodo() {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<void> getAuthToken() {
    // this methods will get token and save for later usecase
    return remoteSource.getAuthToken();
  }

  @override
  Future getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TodoNetwork>>> getTodo(String timeStemp) async {
    try {
      final networkTodos = await remoteSource.getTodo(timeStemp);
      return Right(networkTodos);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(
    String documentId,
    Fields fields,
  ) async {
    try {
      final networkTodos = await remoteSource.updateTodo(documentId, fields);
      return Right(networkTodos);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
