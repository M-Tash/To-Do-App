import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class TaskScreen extends StatefulWidget {
  static const String routeName = 'TaskScreen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  String newTitle = '';
  String newDescription = '';
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    var args = ModalRoute.of(context)?.settings.arguments as Arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: provider.isDarkMode() ? MyTheme.blackColor : Colors.white),
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: provider.isDarkMode() ? MyTheme.blackColor : Colors.white),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Text(
                        AppLocalizations.of(context)!.edit_task,
                        style: Theme.of(context).textTheme.labelLarge,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: args.title,
                    onChanged: (text) {
                      newTitle = text;
                    },
                    style: Theme.of(context).textTheme.displaySmall,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.error_task_title;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: AppLocalizations.of(context)!.task_title_hint,
                        hintStyle: Theme.of(context).textTheme.labelMedium),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: args.description,
                    onChanged: (text) {
                      newDescription = text;
                    },
                    style: Theme.of(context).textTheme.displaySmall,
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.error_task_details;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText:
                        AppLocalizations.of(context)!.task_details_hint,
                        hintStyle: Theme.of(context).textTheme.labelMedium),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    AppLocalizations.of(context)!.select_time,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: showCalendar,
                      child: Text(
                        "${args.selectedDate?.day}/${args.selectedDate?.month}/${args.selectedDate?.year}",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: MyTheme.primaryColor),
                      onPressed: () {
                        FirebaseUtils.updateTaskInFireStore(
                                id: args.id,
                                newTitle: newTitle,
                                newDescription: newDescription,
                                newDate: selectedDate,
                                newIsDone: args.isDone)
                            .then(
                          (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: MyTheme.primaryColor,
                                content: Center(
                                    child: Text(
                                  AppLocalizations.of(context)!
                                      .task_edited_successfully,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ))));
                            provider.getAllTasksFromFireStore();
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.save_changes,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}

class Arguments {
  String? id;
  String? title;
  String? description;
  DateTime? selectedDate;
  bool? isDone;

  Arguments(
      {required this.id,
      required this.title,
      required this.description,
      required this.selectedDate,
      required this.isDone});
}
