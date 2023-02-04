import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_dashboard_widget.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoCubit = sl<TodoCubit>();
    todoCubit.auth();
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoState>(
        bloc: todoCubit,
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthFailed) {
            return const Center(child: Text('Auth is Failed'));
          } else if (state is AuthCompleted) {
            return TodoDashboardWidget();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
