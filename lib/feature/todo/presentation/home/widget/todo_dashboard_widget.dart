import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';

class TodoDashboardWidget extends StatelessWidget {
  TodoDashboardWidget({Key? key}) : super(key: key);

  TextTheme? textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('March 9, 2020',
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(width: 10),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.blueColor,
                ),
              ],
            ),
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
}
