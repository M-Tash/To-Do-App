import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

import 'home/list_tap.dart';
import 'home/settings/settings_tap.dart';

class HomeScreen extends StatefulWidget{
  static const String routeName ='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: MediaQuery.of(context).size.height*0.15,
        title: Text(AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,),



      ),

      bottomNavigationBar:

          BottomAppBar(  color: provider.isDarkMode()?
              MyTheme.blackColor
              :Colors.white
            ,padding: EdgeInsets.all(0.001),
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index){
                selectedIndex =index;
                setState(() {

                });
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
        child: Icon(Icons.add,color: Colors.white,size: 35,),
        onPressed: () {},
      ),


      body: tabs[selectedIndex],


    );
  }
  List<Widget> tabs = [
    ListTap(),
    SettingsTap()
  ];
}
