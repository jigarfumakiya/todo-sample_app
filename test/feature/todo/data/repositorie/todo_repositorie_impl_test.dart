import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart' as di;
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/data/repositories/todo_repositorie_impl.dart';

import '../../../../helper/fixtures.dart';
import '../../../../helper/test_mock.mocks.dart';

void main() {
  late MockTodoRemoteSource mockTodoRemoteSource;
  late TodoRepositoryImpl todoRepository;
  setUp(() async {
    /// It imports the necessary dependencies, initializes the dependency injection container,
    await di.init(isMock: true);

    mockTodoRemoteSource = MockTodoRemoteSource();
    todoRepository = TodoRepositoryImpl(mockTodoRemoteSource);
  });

  group('getTodo', () {
    final todModel = todoFromJson(getTodoRawResponse);
    const timeStamp = '1675535400';
    test('should return todo model when call data is successful', () async {
      // arrange

      when(mockTodoRemoteSource.getTodo(timeStamp))
          .thenAnswer((_) async => todModel);

      // act
      final result = await todoRepository.getTodo(timeStamp);

      // assert
      verify(mockTodoRemoteSource.getTodo(timeStamp));
      expect(result, equals(Right(todModel)));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockTodoRemoteSource.getTodo(timeStamp))
            .thenThrow(ServerException(''));

        // act
        final result = await todoRepository.getTodo(timeStamp);

        // assert
        verify(mockTodoRemoteSource.getTodo(timeStamp));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );
  });

  group('addTodo', () {
    final documentModel = Document.fromJson(jsonDecode(addTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(addTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);

    test('should return todo model when call data is successful', () async {
      // arrange

      when(mockTodoRemoteSource.addTodo(fields))
          .thenAnswer((_) async => documentModel);

      // act
      final result = await todoRepository.addTodo(fields);

      // assert
      verify(mockTodoRemoteSource.addTodo(fields));
      expect(result, equals(Right(documentModel)));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockTodoRemoteSource.addTodo(fields))
            .thenThrow(ServerException(''));

        // act
        final result = await todoRepository.addTodo(fields);

        // assert
        verify(mockTodoRemoteSource.addTodo(fields));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );
  });

  group('updateTodo', () {
    const String documentId = '1axaYZPZUml3pZl5vOkW';
    final documentModel = Document.fromJson(jsonDecode(updateTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(updateTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);

    test('should return todo model when call data is successful', () async {
      // arrange

      when(mockTodoRemoteSource.updateTodo(documentId, fields))
          .thenAnswer((_) async => documentModel);

      // act
      final result = await todoRepository.updateTodo(documentId, fields);

      // assert
      verify(mockTodoRemoteSource.updateTodo(documentId, fields));
      expect(result, equals(Right(documentModel)));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockTodoRemoteSource.updateTodo(documentId, fields))
            .thenThrow(ServerException(''));

        // act
        final result = await todoRepository.updateTodo(documentId, fields);

        // assert
        verify(mockTodoRemoteSource.updateTodo(documentId, fields));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );
  });

  group('getAuthToken', () {
    const String accessToken =
        'eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ';

    test('should return auth token when call data is successful', () async {
      // arrange

      when(mockTodoRemoteSource.getAuthToken())
          .thenAnswer((_) async => accessToken);

      // act
      final result = await todoRepository.getAuthToken();

      // assert
      verify(mockTodoRemoteSource.getAuthToken());
      expect(result, equals(const Right(accessToken)));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockTodoRemoteSource.getAuthToken())
            .thenThrow(ServerException(''));

        // act
        final result = await todoRepository.getAuthToken();

        // assert
        verify(mockTodoRemoteSource.getAuthToken());
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );
  });
}
