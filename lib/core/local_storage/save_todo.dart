// ignore_for_file: always_declare_return_types

import 'package:injectable/injectable.dart';
import 'package:testproject/core/local_storage/shared_prefrensec.dart';
import 'package:testproject/features/todo_list/domain/entities/todo.dart';

abstract class ToDoPreferences {
  saveToDoList(Todo? todo);

  Future<List<Todo>?> getToDoList();

  removeAll();
}

@LazySingleton(as: ToDoPreferences)
class ToDoPreferencesImpl extends BasePreferences implements ToDoPreferences {
  static const String _todoList = 'todoList';

  @override
  void removeAll() {
    remove(_todoList);
  }

  @override
  Future<List<Todo>?> getToDoList() => getTodoList();

  @override
  saveToDoList(Todo? todolist) {
    save('todoList', todoList: todolist != null ? [todolist] : []);
  }
}
