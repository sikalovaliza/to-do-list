import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../screens/home.dart';
import '../../data/database.dart';
import '../../bloc/tasks_bloc/to_do_tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/tasks_widgets/delete_button.dart';

class TaskPage extends StatefulWidget {
  final Task? task;

  const TaskPage({super.key, this.task});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  late TextEditingController _textEditingController;
  String _selectedImportance = 'Нет';
  bool _isDateSet = false;
  DateTime? _selectedDate;
  int? selectedDeadline;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();

    if (widget.task != null) {
      _textEditingController.text = widget.task!.text;
      if (widget.task!.importance == 'important') {
        _selectedImportance = 'Высокий';
      } else if (widget.task!.importance == 'low') {
        _selectedImportance = 'Низкий';
      }
      if (widget.task?.deadline != null) {
        selectedDeadline = widget.task!.deadline;
        _selectedDate =
            DateTime.fromMillisecondsSinceEpoch(selectedDeadline! * 1000);
        _isDateSet = true;
      }
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _showDatePickerDialog() async {
    await initializeDateFormatting('ru');
    final DateTime? picked = await showDatePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      final int deadlineTimestamp = picked.millisecondsSinceEpoch ~/ 1000;
      _selectedDate = picked;
      selectedDeadline = deadlineTimestamp;
    }
    if (mounted) {}
  }

  String importance = 'low';

  void saveTask() {
    String userInput = _textEditingController.text;
    if (widget.task == null && userInput.isNotEmpty) {
      context.read<ToDoTasksBloc>().add(
            TodoTasksAddEvent(
              task: Task(
                  id: DateTime.now().toString(),
                  text: userInput,
                  importance: importance,
                  done: false,
                  deadline: selectedDeadline,
                  createdAt: 12345567,
                  changedAt: 12345667,
                  lastUpdatedBy: "22222332332"),
            ),
          );
    } else if (userInput.isNotEmpty) {
      context.read<ToDoTasksBloc>().add(
            TodoTasksChangeTaskEvent(
              id: widget.task!.id,
              task: Task(
                  id: widget.task!.id,
                  text: userInput,
                  importance: importance,
                  done: false,
                  deadline: selectedDeadline,
                  createdAt: 12345567,
                  changedAt: 12345667,
                  lastUpdatedBy: "20062024"),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => const Main(),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (context) => const Main(),
                ),
              );
              saveTask();
            },
            child: const Text(
              'СОХРАНИТЬ',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: widget.task != null
                  ? const InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(),
                    )
                  : const InputDecoration(
                      hintText: 'Что надо сделать...',
                      border: OutlineInputBorder(),
                    ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  'Важность',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedImportance,
                  items: const [
                    DropdownMenuItem(
                      value: 'Нет',
                      child: Text('Нет'),
                    ),
                    DropdownMenuItem(
                      value: 'Низкий',
                      child: Text('Низкий'),
                    ),
                    DropdownMenuItem(
                      value: 'Высокий',
                      child: Text(
                        '!! Высокий',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedImportance = newValue!;
                      if (_selectedImportance == 'Нет') {
                        importance = 'basic';
                      } else if (_selectedImportance == 'Низкий') {
                        importance = 'low';
                      } else if (_selectedImportance == 'Высокий') {
                        importance = 'important';
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Сделать до',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: _isDateSet,
                  onChanged: (value) {
                    setState(() {
                      _isDateSet = value;
                    });
                    if (value && _selectedDate == null) {
                      _showDatePickerDialog();
                    }
                  },
                ),
              ],
            ),
            if (_selectedDate != null)
              Text(
                DateFormat('dd MMMM yyyy', 'ru').format(_selectedDate!),
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            const SizedBox(height: 16.0),
            DeleteButton(widget: widget),
          ],
        ),
      ),
    );
  }
}
