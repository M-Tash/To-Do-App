import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/list_files/date_widget.dart';
import 'package:todo_app/home/list_files/task_widget.dart';

import '../../providers/app_config_provider.dart';

class ListTap extends StatefulWidget {
  @override
  State<ListTap> createState() => _ListTapState();
}

class _ListTapState extends State<ListTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    if (provider.taskList.isEmpty) {
      provider.getAllTasksFromFireStore();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DateWidget(),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidget(
                task: provider.taskList[index],
              );
            },
            itemCount: provider.taskList.length,
          ),
        )
      ],
    );
  }
}
