import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_dashboard_widget.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: TodoDashboardWidget(),
      ),
    );
  }
}
