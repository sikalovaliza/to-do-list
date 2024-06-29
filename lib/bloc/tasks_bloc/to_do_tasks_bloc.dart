import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/database.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'to_do_tasks_event.dart';
part 'to_do_tasks_state.dart';

class ToDoTasksBloc extends Bloc<ToDoTasksEvent, ToDoTasksState> {
  List<Task> resultList = [];
  List<Task> tasks = items;
  int doneCounter = 0;
  var logger = Logger();
  bool isComplitedHide = false;

  Future<void> saveData(List<Task> tasks, bool isComplitedHide) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJsonList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', tasksJsonList);
    await prefs.setBool('isComplitedHide', isComplitedHide);
  }

  Future<Map<String, dynamic>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJsonList = prefs.getStringList('tasks') ?? [];
    List<Task> tasks = tasksJsonList.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
    bool isComplitedHide = prefs.getBool('isComplitedHide') ?? false;
    
    return {'tasks': tasks, 'isComplitedHide': isComplitedHide};
  }


  ToDoTasksBloc() : super(ToDoTasksInitial()) {
    on<TodoTasksLoadEvent>(_onTasksLoadEvent);
    on<TodoTasksChangeDoneEvent>(_onTasksChangeDoneEvent);
    on<TodoTasksRemoveEvent>(_onTasksRemoveEvent);
    on<TodoTasksAddEvent>(_onTodoTasksAddEvent);
    on<TodoTasksChangeDoneVisibilityEvent>(
        _onTodoTasksChangeDoneVisibilityEvent);
    on<TodoTasksChangeTaskEvent>(_onTodoTasksChangeTaskEvent);
    //on<TodoTasksChange>(_onTodoTasksChange);
  }

  Future<FutureOr<void>> _onTasksLoadEvent(
      TodoTasksLoadEvent event, Emitter<ToDoTasksState> emit) async {
    Map<String, dynamic> data = await loadData();
    tasks = data['tasks'];
    isComplitedHide = data['isComplitedHide'];
    //emit(TodoTaskLoadingState());
    _filterFunction();
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  FutureOr<void> _onTodoTasksChange (
    TodoTasksChangeDoneVisibilityEvent event, Emitter<ToDoTasksState> emit) {
    emit(TodoTaskLoadingState());
    isComplitedHide = !isComplitedHide;
    _filterFunction();
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  FutureOr<void> _onTasksChangeDoneEvent(
    TodoTasksChangeDoneEvent event, Emitter<ToDoTasksState> emit) async {
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter + 1));
    tasks.firstWhere((element) => element.id == event.id).done =
        !tasks.firstWhere((element) => element.id == event.id).done;
    emit(TodoTaskLoadingState());
    _filterFunction();
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  FutureOr<void> _onTasksRemoveEvent(
    TodoTasksRemoveEvent event, Emitter<ToDoTasksState> emit) {
    emit(TodoTaskLoadingState());
    tasks.removeWhere((element) => element.id == event.id);
    _filterFunction();
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  FutureOr<void> _onTodoTasksAddEvent(
    TodoTasksAddEvent event, Emitter<ToDoTasksState> emit) {
    emit(TodoTaskLoadingState());
    tasks.add(event.task);
    _filterFunction();
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  FutureOr<void> _onTodoTasksChangeDoneVisibilityEvent(
    TodoTasksChangeDoneVisibilityEvent event, Emitter<ToDoTasksState> emit) {
    emit(TodoTaskLoadingState());
    isComplitedHide = !isComplitedHide;
    _filterFunction();
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  FutureOr<void> _onTodoTasksChangeTaskEvent(
    TodoTasksChangeTaskEvent event, Emitter<ToDoTasksState> emit) {
    emit(TodoTaskLoadingState());
    _filterFunction();
    tasks[tasks.indexWhere((element) => element.id == event.id)] = event.task;
    emit(TodoTaskLoadedState(tasks: resultList, doneCounter: doneCounter));
  }

  Future<void> _filterFunction() async {
    final List<Task> doneTasks =
        tasks.where((element) => element.done).toList();
    doneCounter = doneTasks.length;
    //
    tasks.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
    resultList = tasks.where((element) => !element.done).toList() +
        (isComplitedHide ? [] : doneTasks);
    await saveData(tasks, isComplitedHide);
  }
}
