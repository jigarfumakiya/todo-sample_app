import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/core/common/app_primary_button.dart';
import 'package:todo_sample_app/core/common/app_text_field.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';

class AddTodoWidget extends StatelessWidget {
  AddTodoWidget({Key? key}) : super(key: key);

  TextTheme? _textTheme;

  final GlobalKey<FormState> _addFormKey = GlobalKey();
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _categoryTextEditingController =
      TextEditingController();
  final TextEditingController _dateTextEditingController =
      TextEditingController();

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
      child: Form(
        key: _addFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'New Task',
              style: _textTheme!.headline1!.copyWith(letterSpacing: 0),
            ),
            const SizedBox(height: 10),
            Divider(color: AppColors.fontColor.withOpacity(.3), thickness: 1),
            SizedBox(height: 10.toHeight),
            AppTextField(
              controller: _titleTextEditingController,
              title: 'Title*',
              hint: 'Title',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add title';
                }
                return null;
              },
            ),
            SizedBox(height: 10.toHeight),
            AppTextField(
              controller: _categoryTextEditingController,
              title: 'Category',
              hint: 'Category',
            ),
            SizedBox(height: 10.toHeight),
            AppTextField(
              controller: _dateTextEditingController,
              title: 'When *',
              hint: '05/02/23',
              suffix:
                  const Icon(Icons.calendar_month, color: AppColors.blueColor),
              textInputType: TextInputType.datetime,
              validator: (value) {
                //todo add validation for previous date
                if (value!.isEmpty) {
                  return 'Please add when';
                }
                return null;
              },
            ),
            SizedBox(height: 20.toHeight),
            Center(
              child: AppPrimaryButton(
                onTap: () {},
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onAddTap() {}
}
