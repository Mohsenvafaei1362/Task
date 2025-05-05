import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:testproject/core/extentions/extention.dart';
import 'package:testproject/core/network/di/di.dart';
import 'package:testproject/features/todo_list/domain/entities/todo.dart';
import 'package:testproject/features/todo_list/presentation/bloc/todo_bloc.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TodoBloc bloc;

  @override
  void initState() {
    bloc = getIt<TodoBloc>();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go('/todo');
        }
      },
      child: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 50,
                title: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // ویجت‌ها به سمت چپ
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/todo');
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 90),
                    Text(
                      'Task',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 37, 30, 33),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitlePage(),
                          SizedBox(height: 16),
                          AddTaskName(bloc: bloc),
                          SizedBox(height: 30),
                          ShowHours(bloc: bloc),
                          SizedBox(height: 30),
                          SelectedToday(bloc: bloc),
                          SizedBox(height: 60),
                          WidgetButton(bloc: bloc),
                          SizedBox(height: 14),
                          WidgetText(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//! widget text
class WidgetText extends StatelessWidget {
  const WidgetText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'If you disable today, the task will be considered as tomorrow',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xff3C3C43).withAlpha(100),
      ),
    );
  }
}

//! button widget
class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key, required this.bloc});
  final TodoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (bloc.taskName.isEmpty) {
          final overlay = Overlay.of(context);
          final overlayEntry = overlayDialog(
            Text(
              'Error',
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: CupertinoColors.destructiveRed,
              ),
            ),
            Icon(
              CupertinoIcons.clear_thick_circled,
              color: CupertinoColors.destructiveRed,
            ),
          );

          overlay.insert(overlayEntry);

          Future.delayed(Duration(seconds: 4), () {
            overlayEntry.remove();
          });
        } else {
          if (bloc.isSelected) {
            bloc
                .saveTodo(
                  Todo(
                    title: bloc.taskName,
                    isCompleted: bloc.isSelected,
                    time: bloc.dateTime.value,
                    statusTime:
                        bloc.hurs.value >= 12 && bloc.minut.value > 0
                            ? 'PM'
                            : 'AM',
                  ),
                )
                .then((value) {
                  context.go('/todo');
                  FocusScope.of(context).unfocus();

                  //! نمایش پیام  با Overlay
                  final overlay = Overlay.of(context);
                  final overlayEntry = overlayDialog(
                    Text(
                      'Task added successfully',
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(color: CupertinoColors.systemGreen),
                    ),

                    Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: CupertinoColors.systemGreen,
                    ),
                  );

                  overlay.insert(overlayEntry);

                  Future.delayed(Duration(seconds: 4), () {
                    overlayEntry.remove();
                  });
                });
          } else {
            bloc
                .saveTodoTomorrow(
                  Todo(
                    title: bloc.taskName,
                    isCompleted: bloc.isSelected,
                    time: bloc.dateTime.value,
                    statusTime:
                        bloc.hurs.value >= 12 && bloc.minut.value > 0
                            ? 'PM'
                            : 'AM',
                  ),
                )
                .then((value) {
                  context.go('/todo');
                  FocusScope.of(context).unfocus();

                  //! نمایش پیام  با Overlay
                  final overlay = Overlay.of(context);
                  final overlayEntry = overlayDialog(
                    Text(
                      'Task added successfully',
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(color: CupertinoColors.systemGreen),
                    ),
                    Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: CupertinoColors.systemGreen,
                    ),
                  );

                  overlay.insert(overlayEntry);

                  Future.delayed(Duration(seconds: 4), () {
                    overlayEntry.remove();
                  });
                });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(context.screenwidth * 0.8, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
      child: Text(
        'Done',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  //! نمایش پیام  با Overlay
  OverlayEntry overlayDialog(Widget text, Widget icon) {
    return OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 20,
            right: 20,
            child: CupertinoPopupSurface(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemTeal.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [icon, SizedBox(width: 8), text],
                ),
              ),
            ),
          ),
    );
  }
}

//! selected today widget
class SelectedToday extends StatefulWidget {
  const SelectedToday({super.key, required this.bloc});
  final TodoBloc bloc;
  @override
  State<SelectedToday> createState() => _SelectedTodayState();
}

class _SelectedTodayState extends State<SelectedToday> {
  // bool isSelected = true; //! وضعیت انتخاب شده
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Today',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Switch(
          value: widget.bloc.isSelected,
          onChanged: (value) {
            setState(() {
              widget.bloc.isSelected = value;
            });
          },
          activeColor: Colors.white,
          activeTrackColor: Colors.green,
        ),
      ],
    );
  }
}

//! show hours widget
class ShowHours extends StatelessWidget {
  const ShowHours({super.key, required this.bloc});
  final TodoBloc bloc;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenwidth * .7,
      child: Row(
        children: [
          Text(
            'Hour',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 20),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xff76801f).withAlpha(20),
            ),
            width: 90,
            height: 36,
            child: StreamBuilder<String>(
              stream: bloc.dateTime.stream,
              builder: (context, snapshot) {
                return SizedBox.expand(
                  // این ویجت باعث پر شدن کامل فضای Container می‌شود
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: snapshot.data,
                      hintStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    onTap: () async {
                      var time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.input,
                        builder: (BuildContext context, Widget? child) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: MediaQuery(
                              data: MediaQuery.of(
                                context,
                              ).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            ),
                          );
                        },
                      );
                      if (time != null) {
                        bloc.hurs.sink.add(time.hour);
                        bloc.minut.sink.add(time.minute);
                        bloc.dateTime.sink.add(
                          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 5),
          Container(
            alignment: Alignment.center,
            width: 52,
            height: 31,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: StreamBuilder3(
              streams: StreamTuple3<String, int, int>(
                bloc.dateTime.stream,
                bloc.hurs.stream,
                bloc.minut.stream,
              ),
              builder: (context, snapshot) {
                return Text(
                  snapshot.snapshot2.data != null &&
                          snapshot.snapshot2.data! >= 12 &&
                          snapshot.snapshot3.data != null &&
                          snapshot.snapshot3.data! > 0
                      ? 'PM'
                      : 'AM',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//! add task name widget
class AddTaskName extends StatelessWidget {
  const AddTaskName({super.key, required this.bloc});
  final TodoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Name',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: context.screenwidth * 0.5,
          child: TextField(
            onChanged: (value) {
              bloc.taskName = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter task name',
              fillColor: Colors.transparent,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//! title widget
class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add a task',
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
    );
  }
}
