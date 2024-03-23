import 'package:flutter/material.dart';

void main() {
  runApp(TaskListApp());
}

class TaskListApp extends StatelessWidget {
  final TaskListController controller = TaskListController();

  TaskListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task List'),
        ),
        body: TaskListView(controller: controller),
      ),
    );
  }
}

class Task {
  String title;
  bool completed;

  Task(this.title, this.completed);
}

class TaskListView extends StatefulWidget {
  final TaskListController controller;

  const TaskListView({super.key, required this.controller});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.controller.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.controller.tasks[index];
        return ListTile(
          title: Text(task.title),
          leading: Checkbox(
            value: task.completed,
            onChanged: (value) {
              setState(() => widget.controller.toggleTaskCompletion(index));
            },
          ),
        );
      },
    );
  }
}

class TaskListController {
  List<Task> tasks = [
    Task('Task 1', false),
    Task('Task 2', true),
    Task('Task 3', false),
  ];

  void toggleTaskCompletion(int index) {
    tasks[index].completed = !tasks[index].completed;
  }
}
