import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';

/// Renders item of each todo
/// whether item is completed or pending
class TodoListItemWidget extends StatelessWidget {
  final TodoNetwork todo;
  final Function(TodoNetwork todos) onChange;

  const TodoListItemWidget({
    Key? key,
    required this.todo,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.scale(
            scale: 1.6,
            child: Checkbox(
              onChanged: (value) {
                onChange(todo);
              },
              value: todo.document.fields.isCompleted.booleanValue,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.document.fields.name.stringValue,
                style: textTheme.bodyText2!.copyWith(
                    color: AppColors.headline2Color,
                    fontWeight: FontWeight.w500),
              ),
              Text(todo.document.fields.categoryId.stringValue,
                  style: textTheme.bodyText2!.copyWith(
                      color: AppColors.body2Color,
                      fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }
}
