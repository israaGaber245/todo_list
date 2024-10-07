import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/list/task_widget_item.dart';
import 'package:todo/home/provider/list_provider.dart';
import 'package:todo/model/task.dart';

import '../provider/app_config_provider.dart';
import '../provider/auth_provider.dart';

class ListTab extends StatefulWidget {

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    var listProvider=Provider.of<ListProvider>(context);
    var authProvider=Provider.of<Authprovider>(context,listen: false);
    listProvider.getAllTasksFormFireStore(authProvider.currentUser?.id??'');

    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectTime,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.changeSelectedTime(date,authProvider.currentUser?.id??'');
          },
          leftMargin: 20,
          monthColor:provider.isDarkMode()?
              MyTheme.white:
          MyTheme.black,
          dayColor: provider.isDarkMode()?
          MyTheme.white:
          MyTheme.black,
          activeDayColor: MyTheme.white,
          activeBackgroundDayColor:provider.isDarkMode()?
              MyTheme.primaryDark:
          MyTheme.primaryLight,
          dotColor: MyTheme.white,
          selectableDayPredicate: (date) => true,
          locale: provider.appLanguage=='en'?
          'en_ISO':
          'ar',
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (context,index){
           return TaskWidgetItem(task: listProvider.taskList[index],);
          },
            itemCount: listProvider.taskList.length,
          ),
        )

      ],
    );
  }


}
