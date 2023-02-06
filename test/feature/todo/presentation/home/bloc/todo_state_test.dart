import 'package:flutter_test/flutter_test.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/bloc/todo_cubit.dart';

void main() {
  group('TodoState', () {
    test('returns correct values for Todo Loading', () {
      final status = TodoLoading();
      expect(status, TodoLoading());
    });

    test('returns correct values for TodoLoaded', () {
      const status = TodoLoaded([], []);
      expect(status, const TodoLoaded([], []));
    });

    test('returns correct values for AuthStatus.failure', () {
      final status = TodoFailure("");
      expect(status, TodoFailure(""));
    });
  });
}
