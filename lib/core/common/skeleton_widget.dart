import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton_todo_widget_test extends StatelessWidget {
  const Skeleton_todo_widget_test({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(color: Colors.white),
      ),
    );
  }
}
