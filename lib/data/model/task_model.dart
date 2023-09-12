// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String title;
  final String? docId;
  final String description;
  final bool completed;
  const TaskModel({
    required this.title,
    required this.description,
    this.docId,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'completed': completed,
      'description': description,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      description: map['description'] as String,
      docId: map['docId'] as String,
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    title,
    description,
    docId,
    completed,
  ];

  TaskModel copyWith({
    String? title,
    String? id,
    String? docId,
    String? description,
    bool? completed,
  }) {
    return TaskModel(
      title: title ?? this.title,
      docId: docId ?? this.docId,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
