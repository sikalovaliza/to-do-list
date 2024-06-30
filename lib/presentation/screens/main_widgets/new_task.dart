import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/tasks_bloc/to_do_tasks_bloc.dart';
import '../../../data/database.dart';

class Fastaddingtask extends StatefulWidget {
  const Fastaddingtask({super.key});

  @override
  State<Fastaddingtask> createState() => _FastaddingtaskState();
}

class _FastaddingtaskState extends State<Fastaddingtask> {
  late TextEditingController _controller;
  bool iconEnabled = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
      child: Row(
        children: [
          IconButton(
            disabledColor: Theme.of(context).colorScheme.shadow,
            onPressed: !iconEnabled
                ? null
                : () {
                    context.read<ToDoTasksBloc>().add(
                          TodoTasksAddEvent(
                            task: Task(
                                id: DateTime.now().toString(),
                                text: _controller.text,
                                importance: 'basic',
                                done: false,
                                createdAt: 122343,
                                changedAt: 123242,
                                lastUpdatedBy: "20062024"),
                          ),
                        );
                    _controller.clear();
                    iconEnabled = false;
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 17,
          ),
          Expanded(
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) {
                setState(() {
                  iconEnabled = _controller.text.isEmpty ? false : true;
                });
              },
              controller: _controller,
              maxLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Новое",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
