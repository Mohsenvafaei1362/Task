import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testproject/core/local_storage/save_todo.dart';
import 'package:testproject/features/todo_list/domain/entities/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ToDoPreferences toDoPreferences;

  final dateTime = BehaviorSubject<String>.seeded('14:00');
  final hurs = BehaviorSubject<int>.seeded(14);
  final minut = BehaviorSubject<int>.seeded(14);
  bool isSelected = true;
  String taskName = '';
  List<Todo>? result = [];
  final List<Todo>? todo = [
    Todo(
      isCompleted: true,
      time: '12:00',
      title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      widget: Checkbox(value: false, onChanged: (value) {}),
    ),
    Todo(
      isCompleted: false,
      time: '12:00',
      title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      widget: Checkbox(value: false, onChanged: (value) {}),
    ),
  ];
  TodoBloc(this.toDoPreferences) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  Future<void> saveTodo(Todo todolist) async {
    await toDoPreferences.saveToDoList(todolist);
  }

  Future<void> getTodo() async {
    await toDoPreferences.getToDoList().then((value) {
      todo?.addAll(value ?? []);
    });
  }

  dispose() {
    dateTime.close();
  }
}
