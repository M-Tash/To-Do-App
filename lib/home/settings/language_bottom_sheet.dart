import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../config/theme/my_theme.dart';
import '../../providers/app_config_provider.dart';


class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(height: MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyTheme.primaryColor,),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                provider.changeLanguage('en');
              },
              child: provider.appLanguage == 'en'
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.english),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                provider.changeLanguage('ar');
              },
              child: provider.appLanguage == 'ar'
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
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
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
            .titleMedium!
            .copyWith(color: Colors.white));
  }
}
