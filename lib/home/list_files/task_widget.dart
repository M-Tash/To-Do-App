import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/list_files/task_edit_screen.dart';

import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';

class TaskWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: MyTheme.primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width * 0.015,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04),
                        child: Text(
                          AppLocalizations.of(context)!.task_temp,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.watch_later_outlined,
                                color: provider.isDarkMode()
                                    ? Colors.white
                                    : MyTheme.darkGreyColor,
                                size: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.02),
                              child: Text(
                                '10:30 ',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(40),
                        width: MediaQuery.of(context).size.width * 0.17,
                        height: MediaQuery.of(context).size.height * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyTheme.primaryColor),
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
}
