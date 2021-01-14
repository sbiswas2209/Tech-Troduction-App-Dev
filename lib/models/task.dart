import 'package:flutter/material.dart';
class Task{
  
  final String title;
  final String content;

  Task({@required this.title , @required this.content});

  factory Task.fromMap({@required Map<String,dynamic> data}){
    return Task(
      title: data['title'] as String, 
      content: data['content'] as String
    );
  }

  Map toMap(){
    return <String, dynamic>{
      'title': this.title,
      'content': this.content
    };
  }

}