import 'package:mockito/annotations.dart';
import 'package:todo_sample_app/feature/todo/data/datasources/todo_remote_source.dart';
import 'package:todo_sample_app/feature/todo/domain/repositories/todo_repositorie.dart';
import 'package:todo_sample_app/feature/todo/domain/usecase/todo_usecase.dart';

@GenerateMocks([TodoRepository, TodoRemoteSource, TodoUseCase])
void main() {}
