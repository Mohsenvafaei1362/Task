import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/features/todo_list/domain/entities/todo.dart';

abstract class BasePreferences {
  static const keyTodo = "todoList";
  static const keyTodoTomorrow = "todoListTomorrow";
  void removeAll();

  Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  void remove(String key) async {
    SharedPreferences prefs = await getPrefs();
    if (prefs.containsKey(key)) {
      await prefs.remove(key);
    }
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString(key);
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getBool(key) ?? false;
  }

  Future<int?> getInt(String key) async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getDouble(key);
  }

  Future<List<Todo>> getTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? todoStrings = prefs.getStringList(keyTodo);

    if (todoStrings == null) {
      return [];
    }
    return todoStrings.map((todoString) {
      final Map<String, dynamic> todoMap = jsonDecode(todoString);
      return Todo.fromJson(todoMap);
    }).toList();
  }

  Future<List<Todo>> getTodoListTomorrow() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? todoStrings = prefs.getStringList(keyTodoTomorrow);

    if (todoStrings == null) {
      return [];
    }
    return todoStrings.map((todoString) {
      final Map<String, dynamic> todoMap = jsonDecode(todoString);
      return Todo.fromJson(todoMap);
    }).toList();
  }

  Future<List<String>?> getList(String key) async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getStringList(key);
  }

  Future<void> save(
    String key, {
    String? stringValue,
    bool? boolValue,
    int? intValue,
    double? doubleValue,
    List<String>? list,
    List<Todo>? todoList,
    // List<Todo>? todoListTomorrow,
  }) async {
    SharedPreferences prefs = await getPrefs();
    if (stringValue != null) {
      await prefs.setString(key, stringValue);
    }
    if (boolValue != null) {
      await prefs.setBool(key, boolValue);
    }
    if (intValue != null) {
      await prefs.setInt(key, intValue);
    }
    if (doubleValue != null) {
      await prefs.setDouble(key, doubleValue);
    }
    if (list != null) {
      await prefs.setStringList(key, list);
    }
    if (todoList != null && key == 'todoList') {
      await prefs.setStringList(
        key,
        todoList.map((todo) => jsonEncode(todo.toJson())).toList(),
      );
    }
    if (todoList != null) {
      await prefs.setStringList(
        key,
        todoList.map((todo) => jsonEncode(todo.toJson())).toList(),
      );
    }
    // if (todoListTomorrow != null) {
    //   await prefs.setStringList(
    //     key,
    //     todoListTomorrow.map((todo) => jsonEncode(todo.toJson())).toList(),
    //   );
    // }
  }
}
