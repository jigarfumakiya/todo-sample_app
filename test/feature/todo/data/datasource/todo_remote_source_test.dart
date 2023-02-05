import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_sample_app/core/exceptions/app_exceptions.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart' as di;
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/core/network/dio_service.dart';
import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

import '../../../../helper/fixtures.dart';

void main() {
  late DioAdapter dioAdapter;
  late TodoRemoteSourceImpl dataSource;

  setUp(() async {
    /// It imports the necessary dependencies, initializes the dependency injection container,
    print('setup');
    await di.init(isMock: true);
    dioAdapter = DioAdapter(dio: sl<Dio>());
    dataSource = TodoRemoteSourceImpl(dioService: sl<DioService>());
  });

  group('Get todo', () {
    final todModel = todoFromJson(getTodoRawResponse);
    const timeStamp = '1675535400';

    test(
      'should return register success model when response code is 200',
      () async {
        /// arrange
        dioAdapter.onPost(
          TodoEndpoints.todoQuery,
          (server) => server.reply(
            200,
            json.decode(getTodoRawResponse),
          ),
          data: todoRequestData,
        );

        /// act
        final result = await dataSource.getTodo(timeStamp);

        /// assert
        expect(todModel, equals(result));
      },
    );

    test(
      'should return register unsuccessful model when response code is 400',
      () async {
        /// arrange
        dioAdapter.onPost(
          TodoEndpoints.todoQuery,
          (server) => server.reply(
            400,
            json.decode(getTodoRawResponse),
          ),
          data: todoRequestData,
        );

        /// act
        final result = dataSource.getTodo(timeStamp);

        /// assert
        expect(result, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('Add todo', () {
    final documentModel = Document.fromJson(jsonDecode(addTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(addTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);
    test(
      'should return register success model when response code is 200',
      () async {
        /// arrange
        dioAdapter.onPost(
          TodoEndpoints.addTodo,
          (server) {
            return server.reply(
              200,
              json.decode(addTodoRawResponse),
            );
          },
          data: fields.toJson(),
        );

        /// act
        final result = await dataSource.addTodo(fields);

        /// assert
        expect(documentModel, equals(result));
      },
    );

    test(
      'should return register unsuccessful model when response code is 400',
      () async {
        /// arrange
        dioAdapter.onPost(
          TodoEndpoints.addTodo,
          (server) => server.reply(
            400,
            json.decode(addTodoRawResponse),
          ),
          data: fields.toJson(),
        );

        /// act
        final result = dataSource.addTodo(fields);

        /// assert
        expect(result, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('update Todo', () {
    const String documentId = '1axaYZPZUml3pZl5vOkW';
    final documentModel = Document.fromJson(jsonDecode(updateTodoRawResponse));
    final Map<String, dynamic> jsonMap = jsonDecode(updateTodoRequest);
    final fields = Fields.fromJson(jsonMap['fields']);
    const updateEndpoint = "${TodoEndpoints.addTodo}/$documentId";
    test(
      'should return register success model when response code is 200',
      () async {
        /// arrange
        dioAdapter.onPatch(
          updateEndpoint,
          (server) {
            return server.reply(
              200,
              json.decode(updateTodoRawResponse),
            );
          },
          data: fields.toJson(),
        );

        /// act
        final result = await dataSource.updateTodo(documentId, fields);

        /// assert
        expect(documentModel, equals(result));
      },
    );

    test(
      'should return register unsuccessful model when response code is 400',
      () async {
        /// arrange
        dioAdapter.onPost(
          updateEndpoint,
          (server) => server.reply(
            400,
            json.decode(updateTodoRawResponse),
          ),
          data: fields.toJson(),
        );

        /// act
        final result = dataSource.addTodo(fields);

        /// assert
        expect(result, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
