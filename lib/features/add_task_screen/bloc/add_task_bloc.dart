
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/data/model/task_model.dart';
import 'package:tasksapp/data/repository/tasks_repository.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  TaskRepository taskRepository = TaskRepository();
  AddTaskBloc() : super(AddTaskInitial()) {
    on<AddingTaskEvent>((event, emit) async{
      emit(AddingTaskLoad());
      try {
        await taskRepository.addATask(taskModel: event.task);
        emit(AddingTaskSuccess());
      } catch (e) {
        emit(AddingTaskError(e.toString()));
      }
    });
  }
}
