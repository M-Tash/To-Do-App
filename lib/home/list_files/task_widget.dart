import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/list_files/task_edit_screen.dart';
import 'package:todo_app/providers/user_provider.dart';

import '../../config/theme/my_theme.dart';
import '../../model/task.dart';
import '../../providers/app_config_provider.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late AppConfigProvider provider;
  late UserProvider userProvider;

  bool isTaskDone = false;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    //delete
                    deleteTaskWidget();
                  },
                  backgroundColor: MyTheme.redColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: AppLocalizations.of(context)!.delete,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(context, TaskScreen.routeName,
                        arguments: Arguments(
                            id: widget.task.id,
                            title: widget.task.title,
                            description: widget.task.description,
                            selectedDate: widget.task.dateTime,
                            isDone: widget.task.isDone));
                  },
                  backgroundColor: MyTheme.primaryColor,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: AppLocalizations.of(context)!.edit,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  color:
                  provider.isDarkMode() ? MyTheme.blackColor : Colors.white,
                  borderRadius: BorderRadius.circular(7)),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: widget.task.isDone == true
                            ? Colors.green
                            : MyTheme.primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width * 0.015,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title ?? '',
                          style: widget.task.isDone == true
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.green)
                              : Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          width: 160,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              text: widget.task.description ?? '',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        widget.task.isDone = true;
                        updateTaskWidget();
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.all(40),
                        width: MediaQuery.of(context).size.width * 0.17,
                        height: MediaQuery.of(context).size.height * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: widget.task.isDone == true
                                ? Colors.green
                                : MyTheme.primaryColor),
                        child: const Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Colors.white,
                          size: 35,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteTaskWidget() {
    FirebaseUtils.deleteTaskFromFireStore(
            widget.task, userProvider.currentUser!.id!)
        .then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MyTheme.primaryColor,
            content: Center(
                child: Text(
              AppLocalizations.of(context)!.task_deleted_successfully,
              style: Theme.of(context).textTheme.bodyLarge,
            ))));
        provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
      },
    );
  }

  void updateTaskWidget() {
    FirebaseUtils.updateTaskInFireStore(
        uId: userProvider.currentUser!.id!,
        id: widget.task.id ?? '',
        newTitle: widget.task.title ?? '',
        newDescription: widget.task.description ?? '',
        newIsDone: widget.task.isDone,
        newDate: widget.task.dateTime!);
  }
}
