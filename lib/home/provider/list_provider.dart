import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_utils.dart';
import '../../model/task.dart';

class ListProvider extends ChangeNotifier{
  List<Task>taskList=[];
  DateTime selectTime=DateTime.now();
  void getAllTasksFormFireStore(String uId) async{
    QuerySnapshot<Task>querySnapshot=await FirebaseUtils.getTasksCollection(uId).get();
    taskList= querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    taskList=taskList.where((task){
      if(task.dateTime?.day==selectTime.day&&
          task.dateTime?.month==selectTime.month&&
          task.dateTime?.year==selectTime.year){
        return true;
      }
      return false;
    }).toList();
    taskList.sort(
        (Task task1,Task task2){
          return task1.dateTime!.compareTo(task2.dateTime!);
        }
    );
    notifyListeners();
  }
  void changeSelectedTime(DateTime newTime,String uId){
    selectTime=newTime;
    getAllTasksFormFireStore(uId);
    notifyListeners();
  }
}