import 'package:flutter/material.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';

import '../../../../../core/common/skeleton_widget.dart';

/// A widget that displays a loading skeleton for a Todo List
class SkeletonTodoWidget extends StatelessWidget {
  const SkeletonTodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 20),
          _buildList()
        ],
      ),
    );
  }

  /// Builds the header section of the skeleton loading
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonWidget(
              height: 40.toHeight,
              width: 220.toWidth,
            ),
            SkeletonWidget(
              height: 40.toHeight,
              width: 50.toWidth,
            ),
          ],
        ),
        const SizedBox(height: 10),
        SkeletonWidget(
          height: 10.toHeight,
          width: 100.toWidth,
        ),
      ],
    );
  }

  /// Builds the list section of the skeleton loading
  Widget _buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonWidget(
                  height: 40.toHeight,
                  width: 40.toWidth,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SkeletonWidget(
                      height: 30.toHeight,
                      width: 250.toWidth,
                    ),
                    const SizedBox(height: 10),
                    SkeletonWidget(
                      height: 10.toHeight,
                      width: 100.toWidth,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
