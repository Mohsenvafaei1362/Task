import 'package:flutter/material.dart';

class Todo {
  final String? title;
  bool? isCompleted;
  final String? time;
  final Widget? widget;

  Todo({this.title, this.isCompleted, this.time, this.widget});
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      // initialize properties from json data
      title: json['title'],
      isCompleted: json['isCompleted'],
      time: json['time'],
      widget: json['widget'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'time': time,
      'widget': widget,
    };
  }
}
