import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryLight=Color(0xff5D9CEC);
  static Color white=Color(0xffFFFFFF);
  static Color primaryDark=Color(0xff060E1E);
  static Color green=Color(0xff61E757);
  static Color red=Color(0xffEC4B4B);
  static Color offwhite=Color(0xffDFECDB);
  static Color gray=Color(0xff979ea4);
  static Color black=Color(0xff383838);
  static Color blackDark=Color(0xff141922);
  static ThemeData lightMode=ThemeData(
    scaffoldBackgroundColor: offwhite,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      elevation: 0
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:white),
      titleMedium: TextStyle(fontSize: 20,color: black),
      titleSmall: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLight,
      unselectedItemColor: gray,

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      shape: StadiumBorder(
        side: BorderSide(
          color: white,
          width: 4
        )
      )
    )
  );
  static ThemeData darkMode=ThemeData(
      scaffoldBackgroundColor: black,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryLight,
          elevation: 0
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:white),
          titleMedium: TextStyle(fontSize: 20,color: black),
          titleSmall: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryLight,
        unselectedItemColor: white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          shape: StadiumBorder(
              side: BorderSide(
                  color: primaryDark,
                  width: 4
              )
          )
      )
  );
}