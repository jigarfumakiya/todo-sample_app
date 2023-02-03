import 'package:flutter/material.dart';
import 'package:todo_sample_app/app.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// It imports the necessary dependencies, initializes the dependency injection container,
  await di.init();
  runApp(const TodoApp());
}
