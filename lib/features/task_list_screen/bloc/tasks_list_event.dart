part of 'tasks_list_bloc.dart';

sealed class TasksListEvent extends Equatable {
  const TasksListEvent();

  @override
  List<Object> get props => [];
}

final class GetTasksEvent extends TasksListEvent {}

final class AddButtonClickedEvent extends TasksListEvent {}

final class MarkAsCompletedClickedEvent extends TasksListEvent {
  final String id;
  final TaskModel updatedData;

  const MarkAsCompletedClickedEvent(this.id, this.updatedData);

  @override
  List<Object> get props => [id, updatedData];
}

final class DeleteClickedEvent extends TasksListEvent {
  final String id;

  const DeleteClickedEvent(this.id);

  @override
  List<Object> get props => [id];
}
