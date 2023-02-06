import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sample_app/core/extensions/date.dart';
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
            return Center(
                child: Text(
              state.cause,
              style: Theme.of(context).textTheme.bodyText2,
            ));
          } else if (state is AuthCompleted) {
            return BlocProvider(
              create: (_) => sl<TodoCubit>()
                ..getTodosFromNetwork(DateTime.now().toTimeStamp()),
              child: const TodoDashboardWidget(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
