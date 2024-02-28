import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/providers/user_provider.dart';

import 'home/list_files/list_tap.dart';
import 'home/list_files/task_bottom_sheet.dart';
import 'home/settings/settings_tap.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                provider.taskList = [];
                userProvider.currentUser = null;
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              ))
        ],
        iconTheme: IconThemeData(
            color: provider.isDarkMode() ? MyTheme.blackColor : Colors.white),
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.app_title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: 60,
            ),
            Text(
              '${userProvider.currentUser!.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDarkMode() ? MyTheme.blackColor : Colors.white,
        padding: EdgeInsets.all(0.001),
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/list_icon.png')),
                label: AppLocalizations.of(context)!.list
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/settings_icon.png')),
                label: AppLocalizations.of(context)!.settings
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          showTaskBottomSheet();
        },
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [ListTap(), SettingsTap()];

  void showTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TaskBottomSheet(),
    );
  }
}
