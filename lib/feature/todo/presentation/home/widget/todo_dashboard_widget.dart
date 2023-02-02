import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/date_widget.dart';

class TodoDashboardWidget extends StatelessWidget {
  TodoDashboardWidget({Key? key}) : super(key: key);

  TextTheme? textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.independenceColor,
        elevation: 5,
        title: Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: _buildWidgetBody(context),
    );
  }

  Widget _buildWidgetBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          _buildHeader(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DateWidget(onDateChange: onDateChange),
            IconButton(
              onPressed: () {},
              iconSize: 45,
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

  /// class method
  void onDateChange(DateTime dateTime) {
    print('date change $dateTime');
  }
}
