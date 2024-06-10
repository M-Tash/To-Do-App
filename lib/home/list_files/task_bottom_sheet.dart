import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';

import '../../../providers/app_config_provider.dart';
import '../../config/theme/my_theme.dart';
import '../../model/task.dart';
import '../../providers/user_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late AppConfigProvider provider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: provider.isDarkMode() ? MyTheme.blackColor : Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Text(
                    AppLocalizations.of(context)!.add_new_task,
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (text) {
                  title = text;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.error_task_title;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: AppLocalizations.of(context)!.task_title_hint,
                    hintStyle: Theme.of(context).textTheme.labelMedium),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (text) {
                  description = text;
                },
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.error_task_details;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 20),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: AppLocalizations.of(context)!.task_details_hint,
                    hintStyle: Theme.of(context).textTheme.labelMedium),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                AppLocalizations.of(context)!.select_time,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: showCalendar,
                  child: Text(
                    "${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: MyTheme.primaryColor),
                  onPressed: () {
                    addTask();
                  },
                  child: const Icon(
                    Icons.check_sharp,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: provider.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chosenDate != null) {
      provider.selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (_formKey.currentState!.validate()) {
      Task task = Task(
          title: title,
          description: description,
          dateTime: provider.selectedDate);
      FirebaseUtils.addTaskToFireStore(task, userProvider.currentUser!.id!)
          .then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: MyTheme.primaryColor,
              content: Center(
                  child: Text(
                AppLocalizations.of(context)!.task_added_successfully,
                style: Theme.of(context).textTheme.bodyLarge,
              ))));
          provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
          Navigator.pop(context);
        },
      );
    }
  }
}
