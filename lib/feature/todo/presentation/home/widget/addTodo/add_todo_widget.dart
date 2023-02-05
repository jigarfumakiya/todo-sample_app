import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';

class AddTodoWidget extends StatelessWidget {
  AddTodoWidget({Key? key}) : super(key: key);

  TextTheme? _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: _leadingRow(context),
        leadingWidth: 200,
      ),
      body: _buildBody(),
    );
  }

  Widget _leadingRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 5),
          const Icon(Icons.arrow_back, color: AppColors.independenceColor),
          const SizedBox(width: 10),
          Text('To go back',
              style: _textTheme!.bodyText2!.copyWith(
                color: AppColors.blueColor,
              )),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'New Task',
            style: _textTheme!.headline1!.copyWith(letterSpacing: 0),
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.fontColor.withOpacity(.3), thickness: 1),
        ],
      ),
    );
  }
}
