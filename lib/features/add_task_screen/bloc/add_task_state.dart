part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState{}

final class AddingTaskLoad extends AddTaskState {
  @override
  List<Object> get props => [];
}

final class AddingTaskSuccess extends AddTaskState {
  @override
  List<Object> get props => [];
}

final class AddingTaskError extends AddTaskState {
  final String error;

  const AddingTaskError(this.error);
  @override
  List<Object> get props => [error];
}