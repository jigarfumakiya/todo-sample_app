import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.validator,
    this.maxLine = 1,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int maxLine;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: autovalidateMode,
      style: textTheme.subtitle1!.copyWith(color: Colors.black54, fontSize: 18),
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          label: Text(title),
          hintText: hint,
          filled: true,
          hintStyle: textTheme.subtitle1!
              .copyWith(color: Colors.black54, fontSize: 14),
          labelStyle: textTheme.subtitle1!
              .copyWith(color: Colors.black54, fontSize: 16),
          fillColor: AppColors.textFillColor,
          border: _border(),
          focusedBorder: _border(),
          enabledBorder: _border(),
          prefixIcon: prefix,
          suffixIcon: suffix),
    );
  }

  InputBorder _border() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(
      color: Colors.black54,
    ));
  }
}
