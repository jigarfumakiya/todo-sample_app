import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_list_item_widget.dart';

/// Widget for the todo List
class TodoListWidget extends StatelessWidget {
  const TodoListWidget({
    Key? key,
    required this.todos,
    required this.listKey,
    required this.onTodoStatusChange,
  }) : super(key: key);

  final List<TodoNetwork> todos;
  final GlobalKey<AnimatedListState> listKey;

  final Function(TodoNetwork todo) onTodoStatusChange;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      /// Return the EmptyTodoState widget when there are no todos
      return const EmptyTodoState();
    }

    /// Return an AnimatedList widget when there are todos
    return AnimatedList(
      key: listKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      initialItemCount: todos.length,
      itemBuilder: (context, index, animation) {
        return TodoListItemWidget(
          animation: animation,
          key: ValueKey(todos[index]),
          todo: todos[index],
          onChange: onTodoStatusChange,
        );
      },
    );
  }
}

class EmptyTodoState extends StatelessWidget {
  const EmptyTodoState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.toHeight),
      child: Center(
        child: Text(
          '📝 Add your first task!\n 💪 Let\'s get started! 🎉',
          textAlign: TextAlign.center,
          style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
