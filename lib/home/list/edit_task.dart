import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/app_config_provider.dart';
class EditTask extends StatefulWidget {
 static const String routeName='edit_task';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
 DateTime selectedTime=DateTime.now();
 var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.to_do_list, style: Theme
            .of(context)
            .textTheme
            .titleLarge?.copyWith(
          color: provider.isDarkMode()?
              MyTheme.primaryDark:
              MyTheme.white
        ),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery
                .of(context)
                .size
                .height * 0.06,
            horizontal: MediaQuery
                .of(context)
                .size
                .width * 0.08
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color:provider.isDarkMode()?
                MyTheme.primaryDark:
            MyTheme.white,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.edit_task,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: provider.isDarkMode()?
                  MyTheme.white:
              MyTheme.black),
              textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Form(
                key: formKey,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                          validator: (text){
                            if(text==null||text.isEmpty){
                              return 'please enter your task';
                            }
                          },
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.this_is_title,hintStyle:  Theme
                              .of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold,
                              color:provider.isDarkMode()?
                                  MyTheme.white:
                                  Colors.black
                          ),

                          ),

                      ),
                    ),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (text){
                          if(text==null||text.isEmpty){
                            return 'please enter your description';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.task_details,hintStyle:  Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold,
                            color:provider.isDarkMode()?
                            MyTheme.white:
                            Colors.black )
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_time,style:  Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold,
                          color:provider.isDarkMode()?
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
                        child: Text('${selectedTime.day}-${selectedTime.month}-${selectedTime.year}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: provider.isDarkMode()?
                              MyTheme.white:
                          MyTheme.gray),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(
                      onPressed: (){
                        addTask();
                      },
                      child: Text(AppLocalizations.of(context)!.save_changes,
                        style: TextStyle(color: MyTheme.white),),
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(provider.isDarkMode()?
                          MyTheme.primaryDark:
                          MyTheme.primaryLight)) ,
                    )
                  ],
                )
            ),

          ],
        ),
      ),

    );
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

    }
  }
}
