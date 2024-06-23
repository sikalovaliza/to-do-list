import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'task.dart';

class Task {
  String task = '';
  bool isDone = false;

  Task({required this.task, required this.isDone});
}

final logger = Logger();

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _MainState extends State<Main> {
  List<Task> items = [
    Task(task: 'item 1', isDone: false),
    Task(task: 'item 2', isDone: false),
    Task(task: 'item 3', isDone: false),
    Task(task: 'item 4', isDone: false),
    Task(task: 'item 5', isDone: false),
    Task(task: 'item 6', isDone: false),
    Task(task: 'item 7', isDone: false),
    Task(task: 'item 8', isDone: false),
    Task(task: 'item 9', isDone: false),
    Task(task: 'item 10', isDone: false),
    Task(task: 'item 11', isDone: false),
    Task(task: 'item 12', isDone: false),
    Task(task: 'item 13', isDone: false),
    Task(
        task:
            'item 14авлыопворалврпвлраплырплвыоапрлвырплвораплырлоарпвлорплворповлапывларпвыпвпаывапвыппывппыапыпыпаыыылпвылрпыалпа',
        isDone: false),
    Task(task: 'item 15', isDone: false),
    Task(task: 'item 16', isDone: false),
    Task(task: 'item 17', isDone: false),
    Task(task: 'item 18', isDone: false),
    Task(task: 'item 19', isDone: false),
    Task(task: 'item 20', isDone: false),
  ];

  List<Task> doneItems = [
    Task(task: 'item 1', isDone: false),
    Task(task: 'item 2', isDone: false),
    Task(task: 'item 3', isDone: false),
    Task(task: 'item 4', isDone: false),
    Task(task: 'item 5', isDone: false),
    Task(task: 'item 6', isDone: false),
    Task(task: 'item 7', isDone: false),
    Task(task: 'item 8', isDone: false),
    Task(task: 'item 9', isDone: false),
    Task(task: 'item 10', isDone: false),
    Task(task: 'item 11', isDone: false),
    Task(task: 'item 12', isDone: false),
    Task(task: 'item 13', isDone: false),
    Task(task: 'item 14', isDone: false),
    Task(task: 'item 15', isDone: false),
    Task(task: 'item 16', isDone: false),
    Task(task: 'item 17', isDone: false),
    Task(task: 'item 18', isDone: false),
    Task(task: 'item 19 item 19 ывдаопоапдовыаповдплвыдо', isDone: false),
    Task(task: 'item 20', isDone: false),
  ];

  void removeItem(int index) {
    setState(() {
      if (doneItems.contains(items[index])) {
        int ind = doneItems.indexOf(items[index]);
        doneItems.removeAt(ind);
      }
      items.removeAt(index);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      int ind = doneItems.indexOf(items[index]);
      print(ind);
      items.removeAt(index);
      doneItems[index].isDone = true;
      if (ind != -1) {
        doneItems[ind].isDone = !doneItems[ind].isDone;
      }
    });
  }

  void _showDetails(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskPage(isEdit: true),
      ),
    );
  }

  bool isVisibility = false;

  void _toggleVisibility() {
    setState(() {
      isVisibility = !isVisibility;
      List<Task> newItems = [];
      newItems.addAll(items);
      items = doneItems;
      doneItems = newItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sliverPersistentHeader = SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 180.0,
        maxHeight: 350.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 30, right: 40, left: 40),
          color: const Color.fromARGB(255, 255, 249, 225),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Мои дела',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Visibility(
                      visible: true,
                      child: Text(
                        "Выполнено — 5",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                    IconButton(
                      color: Colors.blue,
                      icon: isVisibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        _toggleVisibility();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 249, 225),
        child: CustomScrollView(slivers: <Widget>[
          sliverPersistentHeader,
          SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index != items.length) {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 0, right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Dismissible(
                      key: Key(items[index].task),
                      background: Container(
                          color: Colors.green,
                          child: const Icon(Icons.check, color: Colors.white)),
                      secondaryBackground: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white)),
                      movementDuration: Duration.zero,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          logger.d('Item completed: ${items[index].task}');
                          _toggleDone(index);
                        } else {
                          removeItem(index);
                          logger.d('Item deleted: ${items[index].task}');
                        }
                      },
                      child: ListTile(
                        leading: Checkbox(
                          value: items[index].isDone,
                          onChanged: (bool? value) {
                            _toggleDone(index);
                          },
                        ),
                        title: Text(
                          items[index].task,
                          style: TextStyle(
                            decoration: items[index].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          maxLines: 3,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () => _showDetails(items[index].task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 0, right: 40, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: const Center(
                        child: Text(
                          "Новое",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                  );
                }
              },
              childCount: items.length + 1,
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskPage(isEdit: false),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
