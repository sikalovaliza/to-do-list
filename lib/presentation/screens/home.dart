import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/presentation/screens/main_widgets/new_task.dart';
import '../../bloc/tasks_bloc/to_do_tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task.dart';
import '../screens/main_widgets/swipe_element.dart';
import '../screens/main_widgets/app_bar.dart';

final logger = Logger();
int countOfDoneTask = 0;
typedef UpdateTextCallback = void Function(
    int index, String newText, String newImportance);

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 249, 225),
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverHeaderWidget(),
            SliverToBoxAdapter(
              child: Card(
                child: Column(
                  children: [
                    BlocBuilder<ToDoTasksBloc, ToDoTasksState>(
                      builder: (context, state) {
                        if (state is TodoTaskLoadedState) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 0, right: 10, left: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TaskItem(
                                  task: state.tasks[index],
                                ),
                              );
                            },
                          );
                        }
                        return const Fastaddingtask();
                      },
                    ),
                    const Fastaddingtask()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TaskPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
