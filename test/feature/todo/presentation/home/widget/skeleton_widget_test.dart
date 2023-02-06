import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/skeleton_todo.dart';

void main() {
  Widget _wrapWithMaterial(Widget body) {
    return ScreenUtilInit(
      /// Set screen size to make responsive
      /// Almost all device
      minTextAdapt: true,
      splitScreenMode: false,
      scaleByHeight: false,
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  group('SkeletonTodoWidget', () {
    testWidgets('should render header and list sections', (tester) async {
      // Arrange
      final widget = _wrapWithMaterial(const SkeletonTodoWidget());

      // Act
      await tester.pumpWidget(widget);

      // Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);
    });
  });
}
