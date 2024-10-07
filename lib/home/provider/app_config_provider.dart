import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage='en';
  ThemeMode theme=ThemeMode.light;
  void changeLanguage(String newLanguage){
    if(newLanguage==appLanguage){
      return;
    }
    else{
      appLanguage=newLanguage;
      notifyListeners();
    }

  }
  void changeTheme(ThemeMode newTheme){
    if(newTheme==theme){
      return;
    }
    else{
      theme=newTheme;
      notifyListeners();
    }
  }
  bool isDarkMode(){
    return theme==ThemeMode.dark;
  }
}