import 'package:dartz/dartz.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

import '../../domain/repositories/todo_repositorie.dart';

/// TodoRepositoryImpl is an implementation of TodoRepository which communicates
/// with a remote source (network) to perform CRUD operations on todo items.
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteSource remoteSource;

  TodoRepositoryImpl(this.remoteSource);

  @override
  Future<Either<Failure, Document>> addTodo(Fields fields) async {
    try {
      final networkTodos = await remoteSource.addTodo(fields);
      return Right(networkTodos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  /// Method to retrieve the authentication token and save it for later use.
  /// Returns the auth token from the remote source.
  @override
  Future<Either<Failure, String>> getAuthToken() async {
    // this methods will get token and save for later usecase
    try {
      final accessToken = await remoteSource.getAuthToken();
      return Right(accessToken);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  /// Method to retrieve todo items based on the time stamp.
  /// Returns a list of TodoNetwork items wrapped in a Right,
  /// or a ServerFailure wrapped in a Left, in case of a server error.
  @override
  Future<Either<Failure, List<TodoNetwork>>> getTodo(String timeStemp) async {
    try {
      final networkTodos = await remoteSource.getTodo(timeStemp);
      return Right(networkTodos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  /// Method to update a todo item based on its document id and fields.
  /// Returns a void wrapped in a Right, or a ServerFailure wrapped in a Left, in case of a server error.
  @override
  Future<Either<Failure, Document>> updateTodo(
    String documentId,
    Fields fields,
  ) async {
    try {
      final networkTodos = await remoteSource.updateTodo(documentId, fields);
      return Right(networkTodos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future getCategories() {
    throw UnimplementedError();
  }
}
