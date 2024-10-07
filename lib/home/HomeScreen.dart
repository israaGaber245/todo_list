import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/home/list/add_task_bottom_sheet.dart';
import 'package:todo/home/provider/app_config_provider.dart';
import 'package:todo/home/provider/auth_provider.dart';
import 'package:todo/home/provider/list_provider.dart';
import 'package:todo/home/setting/setting_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'list/list_tab.dart';

class Homescreen extends StatefulWidget {
  static const String routeName='home_screen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selected=0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    var listProvider=Provider.of<ListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: selected==0?
        Text( AppLocalizations.of(context)!.to_do_list,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: provider.isDarkMode()?
                MyTheme.primaryDark:
                MyTheme.white
          ),):
        Text(AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: provider.isDarkMode()?
              MyTheme.primaryDark:
              MyTheme.white
          ),) ,
        actions: [
          IconButton(onPressed: (){
            var authProvider=Provider.of<Authprovider>(context,listen: false);
            listProvider.taskList=[];
            authProvider.currentUser=null;
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }, icon: Icon(Icons.logout))
        ],
      ),
      body: tabs[selected],
      bottomNavigationBar: BottomAppBar(
        shape:CircularNotchedRectangle() ,
        notchMargin: 8,
        height: 83,
        color:provider.isDarkMode()?
        MyTheme.primaryDark:
        MyTheme.white,
        child: BottomNavigationBar(
          currentIndex: selected,
          onTap: (index){
            selected=index;
            setState(() {

            });
          },
          backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: '')
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showAddTask();
        },
      child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List <Widget>tabs=[ListTab(),SettingTab()];

  void showAddTask() {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    showModalBottomSheet(context: context, builder: (context)=>AddTaskBottomSheet(),
        backgroundColor:provider.isDarkMode()?
            MyTheme.primaryDark:
            Colors.white
    );
  }
}
