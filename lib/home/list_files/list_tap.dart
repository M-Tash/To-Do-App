import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/list_files/date_widget.dart';
import 'package:todo_app/home/list_files/task_widget.dart';

class ListTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DateWidget(),
        Expanded(
          child: ListView(
            children: [
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
            ],
          ),
        )
      ],
    );
  }
}
