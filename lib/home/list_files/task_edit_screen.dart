import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class TaskScreen extends StatelessWidget {
  static const String routeName = 'TaskScreen';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

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
                    child: Text(
                      "11-2-2024",
                      style: Theme.of(context).textTheme.labelMedium,
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
                        if (_formKey.currentState!.validate()) {
                          // TODO submit
                        }
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
}
