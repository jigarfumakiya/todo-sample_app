import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';
import 'package:todo_sample_app/feature/todo/data/models/todo_network.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/todo_list_item_widget.dart';

import '../../../../../helper/fixtures.dart';

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

  group('TodoListItemWidget', () {
    final todModel = todoFromJson(getTodoRawResponse)[0];

    testWidgets('renders todo name and category', (tester) async {
      final widget = _wrapWithMaterial(TodoListItemWidget(
        todo: todModel,
        onChange: (_) {},
        animation: const AlwaysStoppedAnimation(0),
      ));

      await tester.pumpWidget(widget);

      final nameText = find.text('Newly added item');
      expect(nameText, findsOneWidget);

      final categoryText = find.text('New Item');
      expect(categoryText, findsOneWidget);
    });

    testWidgets('checkbox triggers onChange', (tester) async {
      var todoChanged = false;

      final widget = _wrapWithMaterial(TodoListItemWidget(
        todo: todModel,
        onChange: (_) {},
        animation: const AlwaysStoppedAnimation(0),
      ));

      await tester.pumpWidget(widget);

      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);
      await tester.tap(checkbox);
      expect(todoChanged, isFalse);
    });
  });
}
