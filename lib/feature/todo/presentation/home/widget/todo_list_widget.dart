import 'package:flutter/material.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_list_item_widget.dart';

class TodoListWidget extends StatefulWidget {
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
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: widget.listKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      initialItemCount: widget.todos.length,
      itemBuilder: (context, index, animation) {
        return TodoListItemWidget(
          todo: widget.todos[index],
          onChange: widget.onTodoStatusChange,
        );
      },
    );
  }
}
