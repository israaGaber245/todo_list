import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/app_config_provider.dart';

class ShowDialogThemeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.isDarkMode()?
              getSelectedWidget(context,AppLocalizations.of(context)!.dark ) :
              getUnSelectedWidget(context,AppLocalizations.of(context)!.dark )
          ),
          InkWell(
              onTap: (){
                provider.changeTheme(ThemeMode.light);
              },
              child:  provider.isDarkMode()?
              getUnSelectedWidget(context,AppLocalizations.of(context)!.light ):
              getSelectedWidget(context,AppLocalizations.of(context)!.light )
          )
        ],
      ),
    );
  }
  Widget getSelectedWidget(BuildContext context,String text){
    var provider=Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context).textTheme.titleMedium),
          Icon(Icons.check,
            color:provider.isDarkMode()?
            Colors.white:
            Colors.black,
            size: 30,),
        ],
      ),
    );
  }
  Widget getUnSelectedWidget(BuildContext context,String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: Theme.of(context).textTheme.titleMedium ),
    );
  }
}
