import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/constant.dart';
import 'package:tasksapp/features/add_task_screen/page/add_task_screen.dart';
import 'package:tasksapp/features/task_list_screen/bloc/tasks_list_bloc.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          ).then(
              (value) => context.read<TasksListBloc>()..add(GetTasksEvent()));
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<TasksListBloc, TasksListState>(
        listener: (context, state) {
          if (state is TaskDeletedSuccessfullyState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task Deleted Successfully')));
          }
          if (state is TaskMarkedAsCompletedSuccessfullyState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Task has been marked as Completed')));
          }
        },
        builder: (context, state) {
          if (state is TasksListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.errorMsg),
            );
          }
          if (state is TasksListLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total tasks : ${state.tasksList.length}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Completed : ${state.completedTasks}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: state.tasksList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var task = state.tasksList[index];
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title: ${task.title}',
                                  style: kTitleTextStyle,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'ID: ${task.docId}',
                                  style: kDefaultStyle,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Description: ${task.description}',
                                  style: kDefaultStyle,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (task.completed) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Task already marked as Completed'),
                                            ),
                                          );
                                          return;
                                        }
                                        context.read<TasksListBloc>().add(
                                            MarkAsCompletedClickedEvent(
                                                task.docId ?? '',
                                                task.copyWith(
                                                    completed: true)));
                                      },
                                      style: TextButton.styleFrom(
                                        side: const BorderSide(
                                          width: 1.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      child: Text(task.completed
                                          ? 'Completed'
                                          : 'Mark As Completed'),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<TasksListBloc>()
                                            .add(DeleteClickedEvent(
                                              task.docId ?? '',
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
