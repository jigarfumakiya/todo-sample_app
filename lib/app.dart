import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_sample_app/app_cubit.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';
import 'package:todo_sample_app/core/common/internet_not_avaliable.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/auth/auth_widget.dart';

/// The main entry point for the TodoApp
class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  /// State for the [TodoApp]
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final appCubit = sl<AppCubit>();

  @override
  void initState() {
    super.initState();

    /// Call internetCheck on the appCubit when the widget is initialized

    appCubit.internetCheck();
  }

  @override
  Widget build(BuildContext context) {
    /// Set the preferred orientation to portrait up and down
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Return a Material App with the Todo App's theme, title, and home screen
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: Scaffold(
          body: BlocBuilder<AppCubit, AppState>(
            bloc: appCubit,
            builder: (context, state) {
              if (state is AppLoading) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                    Text('Checking internet connectivity...')
                  ],
                );
              } else if (state is AppInternetAvailable) {
                // Show the AuthWidget if the state is AppInternetAvailable
                return const AuthWidget();
              } else {
                // Show the InternetNotAvailableWidget if the state is not AppLoading or AppInternetAvailable
                return const InternetNotAvailableWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
