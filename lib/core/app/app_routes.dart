import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:todo_sample_app/core/extensions/date.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/presentation/addTodo/widget/add_todo_widget.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_dashboard_widget.dart';
import 'package:todo_sample_app/landing_widget.dart';

enum Routes {
  root("/"),

  /// Home Page
  dashboard("/dashboard"),
  addTodo("/add_todo");

  const Routes(this.path);

  final String path;
}

class AppRoutes {
  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        builder: (context, state) => const LandingWidget(),
      ),
      GoRoute(
          path: Routes.dashboard.path,
          name: Routes.dashboard.name,
          builder: (context, state) => BlocProvider(
                create: (_) => sl<TodoCubit>()
                  ..getTodosFromNetwork(DateTime.now().toTimeStamp()),
                child: TodoDashboardWidget(),
              ),
          routes: []),
      GoRoute(
        path: Routes.addTodo.path,
        name: Routes.addTodo.name,
        builder: (context, state) => AddTodoWidget(),
        routes: [],
      ),
    ],
    initialLocation: Routes.root.path,
  );
}
