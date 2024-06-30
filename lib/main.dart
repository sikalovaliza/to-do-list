import 'package:flutter/material.dart';
import 'presentation/screens/home.dart';
import 'bloc/tasks_bloc/to_do_tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru_RU').then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ToDoTasksBloc()..add(TodoTasksLoadEvent()),
        child: const MaterialApp(
          home: Main(),
        ));
  }
}
