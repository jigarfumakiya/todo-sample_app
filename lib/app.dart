import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_sample_app/core/app/app_routes.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';

/// The main entry point for the TodoApp
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Set the preferred orientation to portrait up and down
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Return a Material App with the Todo App's theme, title, and home screen
    return ScreenUtilInit(
      /// Set screen size to make responsive
      /// Almost all device
      designSize: const Size(375, 667),
      builder: (context, child) => MaterialApp.router(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
