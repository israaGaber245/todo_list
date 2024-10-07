import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/list/edit_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/app_config_provider.dart';
import 'package:todo/model/task.dart';

import '../provider/auth_provider.dart';
import '../provider/list_provider.dart';
class TaskWidgetItem extends StatelessWidget {
  Task task;
  TaskWidgetItem({required this.task});
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
   var listProvider=Provider.of<ListProvider>(context);
    var authProvider=Provider.of<Authprovider>(context,listen: false);
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15)
            ),
            onPressed:(context){
              FirebaseUtils.deletTaskToFireStore(task,authProvider.currentUser?.id??'').timeout(
              Duration(milliseconds: 500),
                onTimeout: (){
                print('Task was deleted');
                listProvider.getAllTasksFormFireStore(authProvider.currentUser?.id??'');
                }
              );
            },
            backgroundColor: MyTheme.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),

        ],
      ),

      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(EditTask.routeName);

        },
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:provider.isDarkMode()?
                MyTheme.primaryDark:
            MyTheme.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                width: 4,
                color: MyTheme.primaryLight,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      task.title??''  ,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: MyTheme.primaryLight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(task.description??'',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: provider.isDarkMode()?
                              MyTheme.white:
                              Colors.black
                        )),
                  )
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyTheme.primaryLight),
                child: Icon(
                  Icons.check,
                  size: 25,
                  color: MyTheme.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
