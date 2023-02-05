import 'package:go_router/go_router.dart';
import 'package:todo_sample_app/feature/todo/presentation/addTodo/widget/add_todo_widget.dart';
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
          builder: (context, state) => TodoDashboardWidget(),
          routes: []),
      GoRoute(
        path: Routes.addTodo.path,
        name: Routes.addTodo.name,
        builder: (context, state) => AddTodoWidget(),
        routes: [],
      ),
    ],
  );
}
