import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/core/extensions/date.dart';
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
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    todoCubit.getTodosFromNetwork(DateTime.now().toTimeStamp());
    super.initState();
  }

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
        bloc: todoCubit,
        builder: (context, state) {
          if (state is TodoLoading) {
            return const SkeletonTodoWidget();
          } else if (state is TodoLoaded) {
            return _bodyWithData(
                context, state.inCompletedTodos, state.completedTodos);
          } else if (state is TodosUpdated) {
            return _bodyWithData(
                context, state.inCompletedTodos, state.completedTodos);
          } else if (state is TodoFailure) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, int incompleteTodosCount, int completedTodosCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.toHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DateWidget(
              onDateChange: onDateChange,
              selectedDate: selectedDate,
            ),
            IconButton(
              onPressed: () {},
              iconSize: 45,
              color: AppColors.fontColor,
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
        Text(
          '$incompleteTodosCount incomplete, $completedTodosCount completed',
          style: textTheme!.bodyText1!
              .copyWith(color: AppColors.independenceColor),
        )
      ],
    );
  }

  Widget _bodyWithData(BuildContext context, List<TodoNetwork> inCompleteTodos,
      List<TodoNetwork> completedTodos) {
    return Column(
      children: [
        _buildHeader(context, inCompleteTodos.length, completedTodos.length),
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

  Widget inCompleteWidget(List<TodoNetwork> todos) {
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
            key: UniqueKey(),
            todos: todos,
            listKey: _inCompleteAnimatedListKey,
            onTodoStatusChange: inCompleteStatusChange,
          ),
        ),
      ],
    );
  }

  Widget completeWidget(List<TodoNetwork> todos) {
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
    selectedDate = dateTime;
    todoCubit.getTodosFromNetwork(dateTime.toTimeStamp());
  }

  void inCompleteStatusChange(TodoNetwork todos) {
    /// Update the UI
    /// Remove the data from incomplete list
    final inCompleteTodo = todoCubit.inCompletedTodos;
    final removeIndex = inCompleteTodo.indexOf(todos);

    //Remove data from list
    _inCompleteAnimatedListKey.currentState?.removeItem(
      removeIndex,
      (context, animation) {
        return _buildRemovedItem(todos, context, animation);
      },
    );
    todoCubit.inCompletedTodos.removeAt(removeIndex);

    /// Add data to complete list
    ///
    final fields = todos.document.fields
        .copyWith(isCompleted: IsCompleted(booleanValue: true));
    final doc = todos.document.copyWith(fields: fields);

    final updatedTodo = todos.copyWith(document: doc);
    todoCubit.completedTodos.add(updatedTodo);

    todoCubit.updateTodoStatus(
        updatedTodo, todoCubit.inCompletedTodos, todoCubit.completedTodos);

    /// Set index to trigger the animation
    _completeAnimatedListKey.currentState
        ?.insertItem(todoCubit.completedTodos.indexOf(updatedTodo));
  }

  void completeStatusChange(TodoNetwork todos) {
    /// Update the UI
    /// Remove the data from complete list
    final completeTodo = todoCubit.completedTodos;
    final removeIndex = completeTodo.indexOf(todos);

    //Remove data from list
    _completeAnimatedListKey.currentState?.removeItem(
      removeIndex,
      (context, animation) {
        return _buildRemovedItem(todos, context, animation);
      },
    );
    todoCubit.completedTodos.removeAt(removeIndex);

    /// Add data to incomplete list
    ///
    final fields = todos.document.fields
        .copyWith(isCompleted: IsCompleted(booleanValue: false));
    final doc = todos.document.copyWith(fields: fields);

    final updatedTodo = todos.copyWith(document: doc);
    todoCubit.inCompletedTodos.add(updatedTodo);

    /// Set index to trigger the animation
    final newIndex = todoCubit.inCompletedTodos.indexOf(updatedTodo);

    _inCompleteAnimatedListKey.currentState!.insertItem(newIndex);

    todoCubit.updateTodoStatus(
        updatedTodo, todoCubit.inCompletedTodos, todoCubit.completedTodos);
  }

  Widget _buildRemovedItem(
      TodoNetwork item, BuildContext context, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: TodoListItemWidget(
        todo: item,
        // we dont need to do anything is item is removing
        onChange: (todos) {},
      ),
    );
  }
}
