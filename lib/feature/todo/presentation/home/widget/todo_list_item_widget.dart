import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';

/// Renders item of each todo
/// whether item is completed or pending
class TodoListItemWidget extends StatelessWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.scale(
            scale: 1.6,
            child: Checkbox(
              onChanged: (value) {},
              value: true,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload 1099-R to TurboTax',
                style: textTheme.bodyText2!.copyWith(
                    color: AppColors.headline2Color,
                    fontWeight: FontWeight.w500),
              ),
              Text('💰 Finance',
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
