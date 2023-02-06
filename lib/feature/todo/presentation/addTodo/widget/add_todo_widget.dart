import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/core/app/app_routes.dart';
import 'package:todo_sample_app/core/common/app_date_dialog.dart';
import 'package:todo_sample_app/core/common/app_primary_button.dart';
import 'package:todo_sample_app/core/common/app_text_field.dart';
import 'package:todo_sample_app/core/extensions/date.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/addTodo/bloc/add_todo_cubit.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';

class AddTodoWidget extends StatefulWidget {
  AddTodoWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  TextTheme? _textTheme;

  final GlobalKey<FormState> _addFormKey = GlobalKey();

  final TextEditingController _titleTextEditingController =
      TextEditingController();

  final TextEditingController _categoryTextEditingController =
      TextEditingController();

  final TextEditingController _dateTextEditingController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

  final addTodoCubit = sl<AddTodoCubit>();

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
      body: BlocListener<AddTodoCubit, AddTodoState>(
        bloc: addTodoCubit,
        listener: (context, state) {
          if (state is AddTodoLoading) {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
            );
          } else if (state is AddTodoAdded) {
            Navigator.of(context).pop();
            todoSuccessDialog(context);
          } else if (state is TodoAddingFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: _buildBody(),
      ),
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
        child: BlocBuilder<TodoCubit, TodoState>(
          bloc: sl<TodoCubit>(),
          builder: (context, state) {
            return _buildForm();
          },
        ));
  }

  Widget _buildForm() {
    return Form(
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
          GestureDetector(
            onTap: () {
              // to close the keybored
              FocusScope.of(context).unfocus();
              showDateDialog();
            },
            child: AbsorbPointer(
              child: AppTextField(
                controller: _dateTextEditingController,
                title: 'When *',
                hint: '05/02/23',
                suffix: const Icon(Icons.calendar_month,
                    color: AppColors.blueColor),
                textInputType: TextInputType.datetime,
                validator: (value) {
                  //todo add validation for previous date
                  if (value!.isEmpty) {
                    return 'Please add when';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 20.toHeight),
          Center(
            child: AppPrimaryButton(
              onTap: onAddTap,
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }

  void todoSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('New todo added'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Successfully added new to-do item'),
              SizedBox(height: 10.toHeight),
              AppPrimaryButton(
                onTap: () {
                  // Todo change this logic find a way to send back user
                  context.go(Routes.dashboard.path);
                },
                child: const Text('Go back'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDateDialog() {
    AppDateDialog(
      context: context,
      selectedDate: selectedDate,
      onDateChange: onDateChange,
    ).showDateDialog();
  }

  void onDateChange(DateTime date) {
    setState(() {
      selectedDate = date;
      _dateTextEditingController.text = selectedDate.toDDMMYYYY();
    });
  }

  void onAddTap() {
    if (_addFormKey.currentState!.validate()) {
      final fields = Fields(
        isCompleted: IsCompleted(booleanValue: false),
        date: CategoryId(stringValue: selectedDate.toTimeStamp()),
        categoryId:
            CategoryId(stringValue: _categoryTextEditingController.text),
        name: CategoryId(
          stringValue: _titleTextEditingController.text,
        ),
      );

      addTodoCubit.addTodo(fields);
    }
  }
}
