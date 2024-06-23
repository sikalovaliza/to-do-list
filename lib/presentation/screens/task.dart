import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../screens/home.dart';

class TaskPage extends StatefulWidget {
  bool isEdit = false;
  TaskPage({super.key, required this.isEdit});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool _isDateSet = false;
  String _selectedImportance = 'Нет';
  DateTime? _selectedDate;
  DateTime? _formattedDate;

  void _showDatePickerDialog() async {
    await initializeDateFormatting('ru');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
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
              //todo сохранение новости в общий список
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
            const TextField(
              decoration: InputDecoration(
                hintText: 'Что надо сделать...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              //expands: true,
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
                    if (value) {
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
            TextButton.icon(
              onPressed: () {
                // Действие при нажатии на кнопку "Удалить"
              },
              icon: Icon(Icons.delete,
                  color: widget.isEdit ? Colors.red : Colors.grey),
              label: Text(
                'Удалить',
                style:
                    TextStyle(color: widget.isEdit ? Colors.red : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
