part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class AddingTaskEvent extends AddTaskEvent {
  final TaskModel task;

  const AddingTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}