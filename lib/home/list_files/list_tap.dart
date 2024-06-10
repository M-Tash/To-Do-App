import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/list_files/date_widget.dart';
import 'package:todo_app/home/list_files/task_widget.dart';

import '../../providers/app_config_provider.dart';
import '../../providers/user_provider.dart';

class ListTap extends StatefulWidget {
  const ListTap({super.key});

  @override
  State<ListTap> createState() => _ListTapState();
}

class _ListTapState extends State<ListTap> {
  bool isLoading = true;

  @override
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    getUserId(provider, userProvider);

    return ModalProgressHUD(
      blur: 0.8,
      color: Colors.transparent,
      progressIndicator: const CircularProgressIndicator(color: Colors.white),
      inAsyncCall: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DateWidget(),
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
      ),
    );
  }

  void getUserId(AppConfigProvider provider, UserProvider userProvider) {
    provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
    isLoading = false;
  }
}
