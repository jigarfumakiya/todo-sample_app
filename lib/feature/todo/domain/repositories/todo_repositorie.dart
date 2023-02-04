abstract class TodoRepository {
// this here just for test purpose
// Unless this should be in there own auth repo
  Future<dynamic> getAuthToken();

  Future<dynamic> getCategories();

  Future<dynamic> getTodo();

  Future<dynamic> addTodo();
}
