import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';

import '../../providers/app_config_provider.dart';

class DateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        EasyInfiniteDateTimeLineExample(),
      ]),
    );
  }
}

class EasyInfiniteDateTimeLineExample extends StatefulWidget {
  const EasyInfiniteDateTimeLineExample({super.key});

  @override
  State<EasyInfiniteDateTimeLineExample> createState() =>
      _EasyInfiniteDateTimeLineExampleState();
}

class _EasyInfiniteDateTimeLineExampleState
    extends State<EasyInfiniteDateTimeLineExample> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        EasyInfiniteDateTimeLine(
          showTimelineHeader: false,
          activeColor: MyTheme.primaryColor,
          dayProps: EasyDayProps(
              todayHighlightColor: MyTheme.primaryColor,
              todayStyle: DayStyle(
                  decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? MyTheme.blackColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: MyTheme.primaryColor, width: 2)),
                  dayNumStyle: Theme.of(context).textTheme.titleSmall,
                  dayStrStyle: Theme.of(context).textTheme.displaySmall,
                  monthStrStyle: Theme.of(context).textTheme.displaySmall),
              height: 90,
              dayStructure: DayStructure.dayStrDayNumMonth,
              inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? MyTheme.blackColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  dayNumStyle: Theme.of(context).textTheme.titleSmall,
                  dayStrStyle: Theme.of(context).textTheme.displaySmall,
                  monthStrStyle: Theme.of(context).textTheme.displaySmall)),
          locale: provider.appLanguage,
          controller: _controller,
          firstDate: DateTime(2024),
          focusDate: _focusDate,
          lastDate: DateTime(2026, 12, 31),
          onDateChange: (selectedDate) {
            setState(() {
              _focusDate = selectedDate;
            });
          },
        ),
        Center(
          child: Column(
            children: [
              ButtonTheme(
                minWidth: 50,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: provider.isDarkMode()
                          ? MyTheme.blackColor
                          : Colors.white),
                  onPressed: () {
                    _controller.animateToFocusDate();
                  },
                  child: Text(AppLocalizations.of(context)!.chosen_day,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
              ButtonTheme(
                minWidth: 50,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: provider.isDarkMode()
                          ? MyTheme.blackColor
                          : Colors.white),
                  onPressed: () {
                    _controller.animateToCurrentData();
                  },
                  child: Text(AppLocalizations.of(context)!.today,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
