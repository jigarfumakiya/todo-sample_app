import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.bgColor = AppColors.blueColor,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: child,
      ),
    );
  }
}
