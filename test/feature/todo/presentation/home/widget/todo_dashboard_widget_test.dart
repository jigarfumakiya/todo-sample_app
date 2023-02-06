import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_sample_app/core/app/app_constant.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart' as di;
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/skeleton_todo.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_dashboard_widget.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_list_widget.dart';

import '../../../../../helper/fixtures.dart';

class MockTodoCubit extends MockCubit<TodoState> implements TodoCubit {}

void main() {
  late TodoCubit todoCubit;

  setUp(() async {
    /// It imports the necessary dependencies, initializes the dependency injection container,
    await di.init(isMock: true);
    todoCubit = MockTodoCubit();
  });

  Widget _wrapWithMaterial(Widget body) {
    return ScreenUtilInit(
      /// Set screen size to make responsive
      /// Almost all device
      minTextAdapt: true,
      splitScreenMode: false,
      scaleByHeight: false,
      useInheritedMediaQuery: true,
      builder: (context, child) => BlocProvider(
        create: (context) => todoCubit,
        child: MaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: Scaffold(
            body: body,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'renders Todo dashboard for Todo Loading',
    (tester) async {
      when(() => todoCubit.state).thenReturn(TodoLoading());
      await tester.pumpWidget(
        _wrapWithMaterial(const TodoDashboardWidget()),
      );
      expect(find.byType(SkeletonTodoWidget), findsOneWidget);
    },
  );

  testWidgets(
    'renders Todo dashboard for success state',
    (tester) async {
      final todModel = todoFromJson(getTodoRawResponse);

      final completedTodos = todModel
          .where((element) => element.document.fields.isCompleted.booleanValue)
          .toList(growable: true);
      final inCompletedTodos = todModel
          .where((element) =>
              element.document.fields.isCompleted.booleanValue == false)
          .toList(growable: true);

      when(() => todoCubit.state).thenReturn(
        TodoLoaded(completedTodos, inCompletedTodos),
      );
      await tester.pumpWidget(_wrapWithMaterial(const TodoDashboardWidget()));

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(TodoListWidget), findsNWidgets(2));
    },
  );

  testWidgets(
    'renders Todo dashboard for empty state',
    (tester) async {
      when(() => todoCubit.state).thenReturn(
        const TodoLoaded([], []),
      );
      await tester.pumpWidget(_wrapWithMaterial(const TodoDashboardWidget()));

      expect(find.byType(EmptyTodoState), findsNWidgets(2));
      expect(find.text(emptyTodoMessage), findsNWidgets(2));
    },
  );

  testWidgets(
    'renders Todo dashboard for failure state',
    (tester) async {
      when(() => todoCubit.state).thenReturn(
        TodoFailure(todoFailedMessage),
      );
      await tester.pumpWidget(_wrapWithMaterial(const TodoDashboardWidget()));
      expect(find.text(todoFailedMessage), findsOneWidget);
    },
  );
}
