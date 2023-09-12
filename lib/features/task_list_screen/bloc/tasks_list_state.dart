part of 'tasks_list_bloc.dart';

sealed class TasksListState extends Equatable {
  const TasksListState();

  @override
  List<Object> get props => [];
}

final class TasksListInitial extends TasksListState {}

final class TasksListLoading extends TasksListState {}

final class TasksListLoaded extends TasksListState {
  final List<TaskModel> tasksList;
  final int completedTasks;

  const TasksListLoaded(this.tasksList, this.completedTasks);

  @override
  List<Object> get props => [tasksList, completedTasks];
}

final class ErrorState extends TasksListState {
  final String errorMsg;

  const ErrorState(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}

final class TaskDeletedSuccessfullyState extends TasksListState {
}

final class TaskMarkedAsCompletedSuccessfullyState extends TasksListState {
}
