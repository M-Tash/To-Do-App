import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context,
      required String message,
      bool isDismissible = true}) {
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (context) {
          var provider = Provider.of<AppConfigProvider>(context);

          return AlertDialog(
            backgroundColor:
                provider.isDarkMode() ? MyTheme.blackColor : Colors.white,
            content: Row(
              children: [
                CircularProgressIndicator(color: MyTheme.primaryColor),
                SizedBox(
                  width: 12,
                ),
                Text(message)
              ],
            ),
          );
        });
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: MyTheme.primaryColor,
        content: Center(
            child: Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge,
        ))));
  }
}
