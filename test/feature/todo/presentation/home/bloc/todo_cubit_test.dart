import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart' as di;
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';

import '../../../../../helper/fixtures.dart';
import '../../../../../helper/test_mock.mocks.dart';

void main() {
  late TodoCubit todoCubit;
  // late Login login;
  late MockTodoUseCase mockTodoUseCase;

  /// Initialize data
  setUp(() async {
    /// It imports the necessary dependencies, initializes the dependency injection container,
    await di.init(isMock: true);

    mockTodoUseCase = MockTodoUseCase();
    todoCubit = TodoCubit(mockTodoUseCase);
  });

  ///  Initial data should be loading
  test("Initial data should be AuthStatus.loading", () {
    expect(todoCubit.state, TodoInitial());
  });

  /// Dispose bloc
  tearDown(() {
    todoCubit.close();
  });

  group('Todo Cubit from getTodosFromNetwork ', () {
    final todModel = todoFromJson(getTodoRawResponse);
    const timeStamp = '1675535400';

    final completedTodos = todModel
        .where((element) => element.document.fields.isCompleted.booleanValue)
        .toList(growable: true);
    final inCompletedTodos = todModel
        .where((element) =>
            element.document.fields.isCompleted.booleanValue == false)
        .toList(growable: true);

    blocTest<TodoCubit, TodoState>(
      "When repo success get data should be return TodoState",
      build: () {
        when(mockTodoUseCase.getTodos(timeStamp))
            .thenAnswer((_) async => Right(todModel));
        return todoCubit;
      },
      act: (cubit) => cubit.getTodosFromNetwork(timeStamp),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TodoLoading(),
        TodoLoaded(completedTodos, inCompletedTodos),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      "When user input wrong credential should be return ServerFailure",
      build: () {
        when(mockTodoUseCase.getTodos(timeStamp))
            .thenAnswer((_) async => const Left(ServerFailure('')));

        return todoCubit;
      },
      act: (TodoCubit todoCubit) => todoCubit.getTodosFromNetwork(timeStamp),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TodoLoading(),
        TodoFailure(''),
      ],
    );
  });

  group('Todo Cubit from updateTodoAPI', () {
    const String documentId = '1axaYZPZUml3pZl5vOkW';
    final documentModel = Document.fromJson(jsonDecode(updateTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(updateTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);

    blocTest<TodoCubit, TodoState>(
      "When repo success get data should be return TodoState",
      build: () {
        when(mockTodoUseCase.updateTodos(documentId, fields))
            .thenAnswer((_) async => Right(documentModel));
        return todoCubit;
      },
      act: (cubit) => cubit.updateTodoAPI(documentId, fields),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TodoUpdatedMessage('Todo Status updated successfully'),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      "When user input wrong credential should be return ServerFailure",
      build: () {
        when(mockTodoUseCase.updateTodos(documentId, fields))
            .thenAnswer((_) async => const Left(ServerFailure('')));

        return todoCubit;
      },
      act: (TodoCubit todoCubit) => todoCubit.updateTodoAPI(documentId, fields),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TodoFailure(''),
      ],
    );
  });
}
