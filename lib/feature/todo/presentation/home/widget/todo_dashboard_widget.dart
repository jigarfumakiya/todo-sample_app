import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/date_widget.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/skeleton_todo.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_list_item_widget.dart';

class TodoDashboardWidget extends StatelessWidget {
  TodoDashboardWidget({Key? key}) : super(key: key);

  TextTheme? textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(child: _buildWidgetBody(context)),
    );
  }

  Widget _buildWidgetBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<TodoCubit, TodoState>(
        bloc: sl<TodoCubit>()..getTodosFromNetwork(),
        builder: (context, state) {
          if (state is TodoLoading) {
            return const SkeletonTodoWidget();
          } else if (state is TodoLoaded) {
            final incompleteTodo = state.todos
                .where((element) =>
                    element.fields.isCompleted.booleanValue == true)
                .toList(growable: false);

            return _bodyWithData(context, incompleteTodo);
          } else if (state is TodoFailure) {
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.toHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DateWidget(onDateChange: onDateChange),
            IconButton(
              onPressed: () {},
              iconSize: 45,
              color: AppColors.fontColor,
              style: ButtonStyle(),
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
        Text(
          '5 incomplete, 5 completed',
          style: textTheme!.bodyText1!
              .copyWith(color: AppColors.independenceColor),
        )
      ],
    );
  }

  Widget _bodyWithData(BuildContext context, List<Todos> todos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(context),
        const SizedBox(height: 10),
        Divider(color: AppColors.fontColor.withOpacity(.3), thickness: 1),
        const SizedBox(height: 20),
        inCompleteWidget(todos),
      ],
    );
  }

  Widget inCompleteWidget(List<Todos> todos) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Incomplete',
            style: textTheme!.headline1!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.headline2Color,
              letterSpacing: .5,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: AnimatedList(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                initialItemCount: todos.length,
                itemBuilder: (context, index, animation) {
                  final todo = todos[index];
                  return TodoListItemWidget(todo: todo);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// class method
  void onDateChange(DateTime dateTime) {
    print('date change $dateTime');
  }
}
