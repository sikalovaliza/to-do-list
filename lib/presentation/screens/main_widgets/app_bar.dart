import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../data/database.dart';
import '../../../bloc/tasks_bloc/to_do_tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../task.dart';

class SliverHeaderWidget extends StatelessWidget {
  const SliverHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 180.0,
        maxHeight: 350.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 30, right: 40, left: 40),
          color: const Color.fromARGB(255, 255, 249, 225),
          child: BlocBuilder<ToDoTasksBloc, ToDoTasksState>(
            builder: (context, state) {
              return Center(
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
                        Visibility(
                          visible: true,
                          child: Text(
                            "Выполнено - ${state is TodoTaskLoadedState ? state.doneCounter.toString() : " "}",
                            style: const TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        IconButton(
                          color: Colors.blue,
                          icon: context.read<ToDoTasksBloc>().isComplitedHide
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () => context.read<ToDoTasksBloc>()
                          .add(TodoTasksChangeDoneVisibilityEvent()),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )
        )
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

