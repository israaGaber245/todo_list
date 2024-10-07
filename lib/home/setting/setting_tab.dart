import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/setting/show_dialog_language_screen.dart';
import 'package:todo/home/setting/show_dialog_theme_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../MyTheme.dart';
import '../provider/app_config_provider.dart';

class SettingTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: provider.isDarkMode()?
                MyTheme.white:
                Colors.black
            ),),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color:provider.isDarkMode()?
                  MyTheme.blackDark:
              MyTheme.white,
            ),
              child: InkWell(
                onTap: (){
                  showDialogLanguage(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                Text(provider.appLanguage=='en'?
                  AppLocalizations.of(context)!.english:
                AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.primaryLight),),
                Icon(Icons.arrow_drop_down,color:MyTheme.primaryLight)
                            ],
                          ),
              )),
          SizedBox(height: 20,),
          Text(AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: provider.isDarkMode()?
                  MyTheme.white:
                  Colors.black
            ),),
          SizedBox(height: 10,),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color:provider.isDarkMode()?
                      MyTheme.blackDark:
                  MyTheme.white
              ),
              child: InkWell(
                onTap: (){
                  showDialogTheme(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(provider.isDarkMode()?
                    AppLocalizations.of(context)!.dark:
                    AppLocalizations.of(context)!.light ,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.primaryLight),),
                    Icon(Icons.arrow_drop_down,color:MyTheme.primaryLight ,)
                  ],
                ),
              )),

        ],
      ),
    );
    fun(){

    }
  }

  void showDialogLanguage(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
   showDialog(context: context, builder: (context){
     return AlertDialog(
       content: ShowDialogLanguageScreen(),
       title: Text( AppLocalizations.of(context)!.language),
       backgroundColor: provider.isDarkMode()?
       MyTheme.primaryDark:
       MyTheme.primaryLight,
     );

   });
  }

  void showDialogTheme(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: ShowDialogThemeScreen(),
        title: Text( AppLocalizations.of(context)!.mode),
        backgroundColor: provider.isDarkMode()?
        MyTheme.primaryDark:
        MyTheme.primaryLight,
      );

    });
  }
}


