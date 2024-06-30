import 'package:flutter/material.dart';
import '../../../bloc/tasks_bloc/to_do_tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../task.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.widget,
  });

  final TaskPage widget;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context
            .read<ToDoTasksBloc>()
            .add(TodoTasksRemoveEvent(id: widget.task!.id));
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.delete,
          color: widget.task == null ? Colors.red : Colors.grey),
      label: Text(
        'Удалить',
        style: TextStyle(color: widget.task == null ? Colors.red : Colors.grey),
      ),
    );
  }
}
