import 'package:flutter/cupertino.dart';
import 'package:todo/model/my_user.dart';

class Authprovider extends ChangeNotifier{
  MyUser? currentUser;
  void updateUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }
}