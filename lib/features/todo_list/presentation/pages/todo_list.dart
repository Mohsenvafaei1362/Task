import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/core/network/di/di.dart';
import 'package:testproject/features/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:testproject/gen/assets.gen.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late TodoBloc bloc;

  // لیست وضعیت هر چک‌باکس
  List<bool> isCheckedList = List.generate(5, (_) => false);
  getTodo() async {
    await bloc.getTodo();
    await bloc.getTodoTomorrow();
    setState(() {});
  }

  @override
  void initState() {
    bloc = getIt<TodoBloc>();
    getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go('/');
        }
      },
      child: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.small(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  context.go('/addtodo');
                },
                child: Icon(Icons.add, color: Colors.white),
              ),
              appBar: AppBar(
                toolbarHeight: 60,
                actions: [Image.asset(Assets.images.unsplashYMSecCHsIBc.path)],
                actionsPadding: EdgeInsets.symmetric(horizontal: 18),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            'Hide completed',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff3478F6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      ListView.builder(
                        itemCount: bloc.todo?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final data = bloc.todo?[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  activeColor: Colors.black,
                                  value: data?.isCompleted,
                                  onChanged: (value) {
                                    setState(() {
                                      data?.isCompleted = value ?? false;
                                    });
                                  },
                                ),
                                SizedBox(width: 13),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          .6,
                                      child: Text(
                                        data?.title ?? '',
                                        style: TextStyle(
                                          color:
                                              data?.isCompleted != null &&
                                                      data?.isCompleted == true
                                                  ? Colors.grey.shade400
                                                  : Color(0xff737373),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              data?.isCompleted != null &&
                                                      data?.isCompleted == true
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    SizedBox(height: 13),
                                    Text(
                                      "${data?.time} ${bloc.hurs.value >= 12 && bloc.minut.value >= 0 ? 'PM' : 'AM'}",
                                      style: TextStyle(
                                        color:
                                            data?.isCompleted != null &&
                                                    data?.isCompleted == true
                                                ? Colors.grey.shade400
                                                : Color(0xffA3A3A3),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        decoration:
                                            data?.isCompleted != null &&
                                                    data?.isCompleted == true
                                                ? TextDecoration.lineThrough
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Tomorrow',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000),
                        ),
                      ),
                      // Suggested code may be subject to a license. Learn more: ~LicenseLog:3418398354.
                      SizedBox(height: 35),
                      ListView.builder(
                        itemCount: bloc.todoTomorrow?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final data = bloc.todoTomorrow?[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 13),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 290,
                                      child: Text(
                                        data?.title ?? '',
                                        style: TextStyle(
                                          color: Color(0xff737373),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 13),
                                    Text(
                                      data?.time ?? '',
                                      style: TextStyle(
                                        color: Color(0xffA3A3A3),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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
