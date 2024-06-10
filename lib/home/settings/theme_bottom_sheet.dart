import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../config/theme/my_theme.dart';
import '../../providers/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(height: MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),color: MyTheme.primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.light);
              },
              child: provider.isDarkMode()
                  ? getUnSelectedItemWidget(AppLocalizations.of(context)!.light)
                  : getSelectedItemWidget(AppLocalizations.of(context)!.light),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.isDarkMode()
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                  : getUnSelectedItemWidget(AppLocalizations.of(context)!.dark),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyTheme.blackColor, fontWeight: FontWeight.bold)),
        Icon(
          Icons.check,
          size: 30,
          color: MyTheme.blackColor,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.white));
  }
}
