import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/list_files/task_edit_screen.dart';

import '../../model/task.dart';
import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  late AppConfigProvider provider;

  bool istaskDone = false;

  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: ScrollMotion(),
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
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(context, TaskScreen.routeName);
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
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: istaskDone == true
                            ? Colors.green
                            : MyTheme.primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width * 0.015,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title ?? '',
                          style: istaskDone == true
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.green)
                              : Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(widget.task.description ?? '',
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        istaskDone = true;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(40),
                        width: MediaQuery.of(context).size.width * 0.17,
                        height: MediaQuery.of(context).size.height * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: istaskDone == true
                                ? Colors.green
                                : MyTheme.primaryColor),
                        child: Icon(
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
    FirebaseUtils.deleteTaskFromFireStore(widget.task)
        .timeout(Duration(milliseconds: 250), onTimeout: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: MyTheme.primaryColor,
          content: Center(
              child: Text(
            AppLocalizations.of(context)!.task_deleted_successfully,
            style: Theme.of(context).textTheme.bodyLarge,
          ))));
      provider.getAllTasksFromFireStore();
    });
  }
}
