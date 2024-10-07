import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/home/HomeScreen.dart';
import 'package:todo/home/list/edit_task.dart';
import 'package:todo/home/provider/auth_provider.dart';
import 'package:todo/home/provider/list_provider.dart';
import 'home/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main()async{
 // WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
 // await FirebaseFirestore.instance.disableNetwork();
 // FirebaseFirestore.instance.settings =
    //  Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context)=>AppConfigProvider()),
  ChangeNotifierProvider(create: (context)=>ListProvider()),
  ChangeNotifierProvider(create: (context)=>Authprovider(),)
    ],
        child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
   return  MaterialApp(
     initialRoute: RegisterScreen.routeName,
     routes:{
       Homescreen.routeName:(context)=>Homescreen(),
       EditTask.routeName:(context)=>EditTask(),
       RegisterScreen.routeName:(context)=>RegisterScreen(),
       LoginScreen.routeName:(context)=>LoginScreen()
     },
     home: RegisterScreen(),
     localizationsDelegates:AppLocalizations.localizationsDelegates,
     supportedLocales: AppLocalizations.supportedLocales,
     darkTheme: MyTheme.darkMode,
     theme: MyTheme.lightMode,
     locale: Locale(provider.appLanguage),
     themeMode: provider.theme,
   );
  }
}

