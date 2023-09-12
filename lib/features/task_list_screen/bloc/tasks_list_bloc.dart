import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/data/model/task_model.dart';
import 'package:tasksapp/data/repository/tasks_repository.dart';

part 'tasks_list_event.dart';
part 'tasks_list_state.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  TaskRepository taskRepository = TaskRepository();
  TasksListBloc() : super(TasksListInitial()) {
    on<GetTasksEvent>((event, emit) async {
      emit(TasksListLoading());
      try {
        final dataMap = await taskRepository.getAllTasks();
        emit(TasksListLoaded(dataMap['taskData'], dataMap['completedCount']));
      } catch (e) {
        log(e.toString());
        emit(ErrorState(e.toString()));
      }
    });

    on<MarkAsCompletedClickedEvent>((event, emit) async {
      emit(TasksListLoading());
      try {
        await taskRepository.updateTask(id: event.id, task: event.updatedData);
        final dataMap = await taskRepository.getAllTasks();
        emit(TaskMarkedAsCompletedSuccessfullyState());
        emit(TasksListLoaded(dataMap['taskData'], dataMap['completedCount']));
      } catch (e) {
        log(e.toString());
        emit(ErrorState(e.toString()));
      }
    });

    on<DeleteClickedEvent>((event, emit) async {
      emit(TasksListLoading());
      try {
        await taskRepository.deleteATask(id: event.id);
        final dataMap = await taskRepository.getAllTasks();
        emit(TaskDeletedSuccessfullyState());

        emit(TasksListLoaded(dataMap['taskData'], dataMap['completedCount']));
      } catch (e) {
        log(e.toString());
        emit(ErrorState(e.toString()));
      }
    });
  }
}
