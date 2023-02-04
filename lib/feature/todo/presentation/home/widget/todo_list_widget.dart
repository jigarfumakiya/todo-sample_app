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

  final List<Todos> todos;
  final GlobalKey<AnimatedListState> listKey;

  final Function(Todos todo) onTodoStatusChange;

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  void initState() {
    super.initState();
  }

  /// The builder function used to build items that have been removed.
  ///
  /// Used to build an item after it has been removed from the list. This method
  /// is needed because a removed item remains visible until its animation has
  /// completed (even though it's gone as far as this ListModel is concerned).
  /// The widget will be used by the [AnimatedListState.removeItem] method's
  /// [AnimatedRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      Todos item, BuildContext context, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: TodoListItemWidget(
        todo: item,
        onChange: widget.onTodoStatusChange,
        // No gesture detector here: we don't want removed items to be interactive.
      ),
    );
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
