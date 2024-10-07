import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading(BuildContext context,String message){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder:(context){
      return AlertDialog(
        content:Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12,),
            Text(message)
          ],
        ) ,
      );
        });
  }
  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }
  static void showMessage(BuildContext context,String message,
  { String? title,String? posActionName,VoidCallback? posAction,
    String? negActionName,VoidCallback? negAction,bool barrierDismissible=true}){
    List<Widget>actions=[];
    if(posActionName!=null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)
      )
      );
    }
    if(negActionName!=null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName)
      )
      );
    }
    showDialog(barrierDismissible:barrierDismissible ,
        context: context, builder: (context){
      return AlertDialog(
        content: Text(message),
        title: Text(title??'title'),
        actions: actions,
      );
    });
  }
}