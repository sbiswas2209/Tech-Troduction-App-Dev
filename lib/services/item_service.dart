import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/models/task.dart';
class ItemService{

  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  Future<List<Task>> getTasks() async {
    SharedPreferences _prefs = await _sharedPreferences;
    List<String> tasksList = [];
    try{
      tasksList = _prefs.getStringList('tasks') ?? [];
    }
    catch(e){
      _prefs.setStringList('tasks', []);
    }
    List<Task> tasks = [];
      tasksList.forEach((element) {
        Map<String , dynamic> data = jsonDecode(element);
        tasks.add(Task.fromMap(data: data));
      });
    return tasks;
  }

  Future saveTask({@required String title, @required String content}) async {
    SharedPreferences _prefs = await _sharedPreferences;
    List<String> tasksList = _prefs.getStringList('tasks') ?? [];
    Map data = Task(title: title, content: content).toMap();
      tasksList.add(jsonEncode(data));
      _prefs.setStringList('tasks', tasksList);
  }

  Future deleteTask({@required int index}) async {
    SharedPreferences _prefs = await _sharedPreferences;
    List<String> tasksList = _prefs.getStringList('tasks');
    tasksList.removeAt(index);
    _prefs.setStringList('tasks', tasksList);
  }

}