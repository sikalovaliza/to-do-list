import 'package:flutter/material.dart';
import '../../../data/database.dart';
import '../../../bloc/tasks_bloc/to_do_tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id),
      background: Container(
        color: Colors.green,
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      movementDuration: Duration.zero,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          //logger.d('Item completed: ${widget.task.id}');
          context
              .read<ToDoTasksBloc>()
              .add(TodoTasksChangeDoneEvent(id: widget.task.id));
        } else {
          context
              .read<ToDoTasksBloc>()
              .add(TodoTasksRemoveEvent(id: widget.task.id));
          //logger.d('Item deleted: ${widget.task.id}');
        }
      },
      child: ListTile(
        leading: Checkbox(
          value: widget.task.done,
          onChanged: (bool? newvalue) async {
            context
                .read<ToDoTasksBloc>()
                .add(TodoTasksChangeDoneEvent(id: widget.task.id));
          },
        ),
        title: Text(
          widget.task.importance == 'important'
              ? '!! ${widget.task.text}'
              : widget.task.importance == 'low'
                  ? '.. ${widget.task.text}'
                  : widget.task.text,
          style: TextStyle(
            decoration: widget.task.done
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: widget.task.importance == 'important'
                ? Colors.red
                : Colors.black,
          ),
          maxLines: 3,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => TaskPage(
                        task: widget.task,
                      )),
            );
          },
        ),
      ),
    );
  }
}
