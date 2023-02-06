// Mocks generated by Mockito 5.3.2 from annotations
// in todo_sample_app/test/helper/test_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart' as _i6;
import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart'
    as _i7;
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart'
    as _i3;
import 'package:todo_sample_app/feature/todo/domain/repositories/todo_repositorie.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDocument_1 extends _i1.SmartFake implements _i3.Document {
  _FakeDocument_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends _i1.Mock implements _i4.TodoRepository {
  MockTodoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> getAuthToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAuthToken,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #getAuthToken,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
  @override
  _i5.Future<dynamic> getCategories() => (super.noSuchMethod(
        Invocation.method(
          #getCategories,
          [],
        ),
        returnValue: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i3.TodoNetwork>>> getTodo(
          String? timeStemp) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTodo,
          [timeStemp],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i3.TodoNetwork>>>.value(
                _FakeEither_0<_i6.Failure, List<_i3.TodoNetwork>>(
          this,
          Invocation.method(
            #getTodo,
            [timeStemp],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i3.TodoNetwork>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, _i3.Document>> addTodo(
          _i3.Fields? fields) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTodo,
          [fields],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, _i3.Document>>.value(
            _FakeEither_0<_i6.Failure, _i3.Document>(
          this,
          Invocation.method(
            #addTodo,
            [fields],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i3.Document>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, _i3.Document>> updateTodo(
    String? documentId,
    _i3.Fields? fields,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTodo,
          [
            documentId,
            fields,
          ],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, _i3.Document>>.value(
            _FakeEither_0<_i6.Failure, _i3.Document>(
          this,
          Invocation.method(
            #updateTodo,
            [
              documentId,
              fields,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i3.Document>>);
}

/// A class which mocks [TodoRemoteSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRemoteSource extends _i1.Mock implements _i7.TodoRemoteSource {
  MockTodoRemoteSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> getAuthToken() => (super.noSuchMethod(
        Invocation.method(
          #getAuthToken,
          [],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<dynamic> getCategories() => (super.noSuchMethod(
        Invocation.method(
          #getCategories,
          [],
        ),
        returnValue: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);
  @override
  _i5.Future<List<_i3.TodoNetwork>> getTodo(String? timestamp) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTodo,
          [timestamp],
        ),
        returnValue:
            _i5.Future<List<_i3.TodoNetwork>>.value(<_i3.TodoNetwork>[]),
      ) as _i5.Future<List<_i3.TodoNetwork>>);
  @override
  _i5.Future<_i3.Document> addTodo(_i3.Fields? fields) => (super.noSuchMethod(
        Invocation.method(
          #addTodo,
          [fields],
        ),
        returnValue: _i5.Future<_i3.Document>.value(_FakeDocument_1(
          this,
          Invocation.method(
            #addTodo,
            [fields],
          ),
        )),
      ) as _i5.Future<_i3.Document>);
  @override
  _i5.Future<_i3.Document> updateTodo(
    String? documentId,
    _i3.Fields? fields,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTodo,
          [
            documentId,
            fields,
          ],
        ),
        returnValue: _i5.Future<_i3.Document>.value(_FakeDocument_1(
          this,
          Invocation.method(
            #updateTodo,
            [
              documentId,
              fields,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Document>);
}