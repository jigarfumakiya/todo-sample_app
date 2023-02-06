import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart' as di;
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

import '../../../../helper/fixtures.dart';
import '../../../../helper/test_mock.mocks.dart';

void main() {
  late MockTodoRepository mockTodoRepository;
  late TodoUseCase todoUseCase;

  setUp(() async {
    /// It imports the necessary dependencies, initializes the dependency injection container,
    await di.init(isMock: true);
    mockTodoRepository = MockTodoRepository();
    todoUseCase = TodoUseCase(mockTodoRepository);
  });

  group('getTodo', () {
    final todModel = todoFromJson(getTodoRawResponse);
    const timeStamp = '1675535400';

    test("should get todo from the repository", () async {
      /// arrange
      when(mockTodoRepository.getTodo(timeStamp))
          .thenAnswer((_) async => Right(todModel));

      /// act
      final result = await todoUseCase.getTodos(timeStamp);

      /// assert
      expect(result, equals(Right(todModel)));
    });

    test("should failure from the repository", () async {
      /// arrange
      when(mockTodoRepository.getTodo(timeStamp))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await todoUseCase.getTodos(timeStamp);

      /// assert
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('addTodos', () {
    final documentModel = Document.fromJson(jsonDecode(addTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(addTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);

    test("should update todo from the repository", () async {
      /// arrange
      when(mockTodoRepository.addTodo(fields))
          .thenAnswer((_) async => Right(documentModel));

      /// act
      final result = await todoUseCase.addTodos(fields);

      /// assert
      expect(result, equals(Right(documentModel)));
    });

    test("should failure from the repository", () async {
      /// arrange
      when(mockTodoRepository.addTodo(fields))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await todoUseCase.addTodos(fields);

      /// assert
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('updateTodos', () {
    const String documentId = '1axaYZPZUml3pZl5vOkW';
    final documentModel = Document.fromJson(jsonDecode(updateTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(updateTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);

    test("should update todo from the repository", () async {
      /// arrange
      when(mockTodoRepository.updateTodo(documentId, fields))
          .thenAnswer((_) async => Right(documentModel));

      /// act
      final result = await todoUseCase.updateTodos(documentId, fields);

      /// assert
      expect(result, equals(Right(documentModel)));
    });

    test("should failure from the repository", () async {
      /// arrange
      when(mockTodoRepository.updateTodo(documentId, fields))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await todoUseCase.updateTodos(documentId, fields);

      /// assert
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('getAuthToken', () {
    const String accessToken =
        'eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ';

    test("should update todo from the repository", () async {
      /// arrange
      when(mockTodoRepository.getAuthToken())
          .thenAnswer((_) async => Right(accessToken));

      /// act
      final result = await todoUseCase.getAuthToken();

      /// assert
      expect(result, equals(Right(accessToken)));
    });

    test("should failure from the repository", () async {
      /// arrange
      when(mockTodoRepository.getAuthToken())
          .thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await todoUseCase.getAuthToken();

      /// assert
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
