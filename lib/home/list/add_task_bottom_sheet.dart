import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/provider/list_provider.dart';

import '../../dialog_utils.dart';
import '../../model/task.dart';
import '../provider/app_config_provider.dart';
import '../provider/auth_provider.dart';
class AddTaskBottomSheet  extends StatefulWidget {


  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedTime=DateTime.now();
  String title='';
  String description='';
late ListProvider listProvider;
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
     listProvider=Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: provider.isDarkMode()?
                    MyTheme.white:
                    Colors.black
              ),),
            Form(
              key: formKey,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        onChanged: (text){
                          title=text;
                        },
                        validator: (text){
                          if(text==null||text.isEmpty){
                            return 'please enter your task';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enter_your_task,
                            hintStyle: TextStyle(fontSize:15,
                            color: provider.isDarkMode()?
                                MyTheme.white:
                                Colors.black
                            )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        onChanged: (text){
                          description=text;
                        },
                          validator: (text){
                            if(text==null||text.isEmpty){
                              return 'please enter your description';
                            }
                          },
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.enter_your_description,
                              hintStyle: TextStyle(fontSize:15,
                              color: provider.isDarkMode()?
                                  MyTheme.white:
                                  Colors.black
                              )
                          ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_time,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: provider.isDarkMode()?
                                MyTheme.white:
                                Colors.black
                          )),
                    ),
                    InkWell(
                      onTap: (){
                        showCalender();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${selectedTime.day}/${selectedTime.month}/${selectedTime.year}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: provider.isDarkMode()?
                          MyTheme.white:
                              Colors.black
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                      addTask();
                    },
                        child: Text(AppLocalizations.of(context)!.add,
                          style: TextStyle(color:MyTheme.white),
                        ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(provider.isDarkMode()?
                            MyTheme.primaryLight:
                        MyTheme.primaryDark
                        )
                      ),
                    )
                  ],
                )
            ),

          ],
        ));
  }

  void showCalender() async {
    var choosenTime = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(choosenTime!=null){
      selectedTime=choosenTime;
      setState(() {

      });
    }
  }

  void addTask() {
    if(formKey.currentState?.validate()==true){
      Task task=Task(
        title:title ,
        description:description ,
        dateTime:selectedTime
      );
      var authProvider=Provider.of<Authprovider>(context,listen: false);
      DialogUtils.showMessage(context, 'waiting...');
      FirebaseUtils.addTaskToFireStore(task,authProvider.currentUser?.id??'')
      .then((value){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Task added successfully',posActionName: 'OK',posAction: (){
          Navigator.pop(context);

        });
      })
          .timeout(
        Duration(microseconds: 500),
        onTimeout: (){
          print('task added succuessfully');
          listProvider.getAllTasksFormFireStore(authProvider.currentUser?.id??'');
          Navigator.pop(context);
        }
      );
    }
  }
}
