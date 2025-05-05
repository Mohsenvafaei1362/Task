// ignore_for_file: always_declare_return_types

import 'package:injectable/injectable.dart';
import 'package:testproject/core/local_storage/shared_prefrensec.dart';
import 'package:testproject/features/todo_list/domain/entities/todo.dart';

abstract class ToDoPreferences {
  saveToDoList(Todo? todo);
  saveToDoListTomorrow(Todo? todo);

  Future<List<Todo>?> getToDoList();
  Future<List<Todo>?> getToDoListTomorrow();

  removeAll();
}

@LazySingleton(as: ToDoPreferences)
class ToDoPreferencesImpl extends BasePreferences implements ToDoPreferences {
  static const String _todoList = 'todoList';
  static const String _todoListtomorrow = 'todoListTomorrow';

  @override
  void removeAll() {
    remove(_todoList);
    remove(_todoListtomorrow);
  }

  @override
  Future<List<Todo>?> getToDoList() => getTodoList();

  @override
  Future<List<Todo>?> getToDoListTomorrow() => getTodoListTomorrow();

  @override
  saveToDoList(Todo? todolist) async {
    final List<Todo>? currentList = await getToDoList();
    final List<Todo> updatedList = [...currentList ?? [], todolist!];
    save('todoList', todoList: updatedList);
  }

  @override
  saveToDoListTomorrow(Todo? todolist) async {
    final List<Todo>? currentList = await getToDoListTomorrow();
    final List<Todo> updatedList = [...currentList ?? [], todolist!];
    save('todoListTomorrow', todoList: updatedList);
  }
}
