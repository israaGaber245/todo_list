import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../MyTheme.dart';
import '../provider/app_config_provider.dart';

class ShowDialogLanguageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                provider.changeLanguage('en');
              },
              child: provider.appLanguage=='en'?
              getSelectedWidget(context,AppLocalizations.of(context)!.english ) :
              getUnSelectedWidget(context,AppLocalizations.of(context)!.english )
          ),
          InkWell(
              onTap: (){
                provider.changeLanguage('ar');
              },
              child:  provider.appLanguage=='ar'?
              getSelectedWidget(context,AppLocalizations.of(context)!.arabic ) :
              getUnSelectedWidget(context,AppLocalizations.of(context)!.arabic )
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
            color: provider.isDarkMode()?
            Colors.white:
            Colors.black,size: 30,),
        ],
      ),
    );
  }
  Widget getUnSelectedWidget(BuildContext context,String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
