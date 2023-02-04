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
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_list_widget.dart';

class TodoDashboardWidget extends StatefulWidget {
  TodoDashboardWidget({Key? key}) : super(key: key);

  @override
  State<TodoDashboardWidget> createState() => _TodoDashboardWidgetState();
}

class _TodoDashboardWidgetState extends State<TodoDashboardWidget> {
  final GlobalKey<AnimatedListState> _inCompleteAnimatedListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _completeAnimatedListKey =
      GlobalKey<AnimatedListState>();

  TextTheme? textTheme;
  final todoCubit = sl<TodoCubit>();

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
        bloc: todoCubit..getTodosFromNetwork(),
        builder: (context, state) {
          if (state is TodoLoading) {
            return const SkeletonTodoWidget();
          } else if (state is TodoLoaded) {
            return _bodyWithData(
                context, state.inCompletedTodos, state.completedTodos);
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

  Widget _bodyWithData(BuildContext context, List<Todos> inCompleteTodos,
      List<Todos> completedTodos) {
    return Column(
      children: [
        _buildHeader(context),
        const SizedBox(height: 10),
        Divider(color: AppColors.fontColor.withOpacity(.3), thickness: 1),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                inCompleteWidget(inCompleteTodos),
                const SizedBox(height: 30),
                completeWidget(completedTodos)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget inCompleteWidget(List<Todos> todos) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TodoListWidget(
            todos: todos,
            listKey: _inCompleteAnimatedListKey,
            onTodoStatusChange: inCompleteStatusChange,
          ),
        ),
      ],
    );
  }

  Widget completeWidget(List<Todos> todos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Completed',
          style: textTheme!.headline1!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.headline2Color,
            letterSpacing: .5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TodoListWidget(
            todos: todos,
            listKey: _completeAnimatedListKey,
            onTodoStatusChange: completeStatusChange,
          ),
        ),
      ],
    );
  }

  /// class method
  void onDateChange(DateTime dateTime) {
    print('date change $dateTime');
  }

  void inCompleteStatusChange(Todos todos) {
    final completeTodo = todoCubit.completedTodos;
    final inCompleteTodo = todoCubit.inCompletedTodos;

    final removeIndex = inCompleteTodo.indexOf(todos);
    //Remove data from list
    _inCompleteAnimatedListKey.currentState?.removeItem(
      removeIndex,
      (context, animation) {
        return _buildRemovedItem(todos, context, animation);
      },
    );
    // Todo implement animation list add feature
    todoCubit.updateTodoStatus(todos);
  }

  void completeStatusChange(Todos todos) {}

  Widget _buildRemovedItem(
      Todos item, BuildContext context, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: TodoListItemWidget(
        todo: item,
        onChange: (todos) {},
        // No gesture detector here: we don't want removed items to be interactive.
      ),
    );
  }
}
