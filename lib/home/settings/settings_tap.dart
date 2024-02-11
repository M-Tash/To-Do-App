import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/settings/theme_bottom_sheet.dart';

import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';
import 'language_bottom_sheet.dart';

class SettingsTap extends StatefulWidget {
  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
        color: Colors.transparent,
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),border: Border.all(color: MyTheme.primaryColor,width: 2),
                      color: provider.isDarkMode()?
                           MyTheme.blackColor
                          :Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          provider.appLanguage == 'en'
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: Theme.of(context).textTheme.bodySmall
                              ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: MyTheme.primaryColor,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  showLanguageBottomSheet();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(color: MyTheme.primaryColor,width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: provider.isDarkMode()?
                           MyTheme.blackColor
                          :Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          provider.isDarkMode()
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: Theme.of(context).textTheme.bodySmall),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: MyTheme.primaryColor,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  showThemeBottomSheet();
                },
              ),
            ],
          ),
        ));
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
