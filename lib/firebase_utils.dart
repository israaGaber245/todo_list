import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task>getTasksCollection(String uId){
    return getUserCollection().doc(uId).collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (snapshot,options)=>Task.formFireStore(snapshot.data()!),
    toFirestore: (task,options)=>task.toFireStore());
  }
 static Future<void> addTaskToFireStore(Task task,String uId){
    var taskCollection=getTasksCollection(uId);
    var docRef=taskCollection.doc();
    task.id=docRef.id;
    return docRef.set(task);
  }
  static Future<void> deletTaskToFireStore(Task task,String uId){
    return getTasksCollection(uId).doc(task.id).delete();
  }
  static CollectionReference<MyUser>getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot,options)=>MyUser.formFireStore(snapshot.data()!),
        toFirestore: (user,options)=>user.toFireStore());
  }
  static Future<void> addUserToFireStore(MyUser myuser){
    return getUserCollection().doc(myuser.id).set(myuser);
  }
  static Future<MyUser?> readUserFormFireStore(String uId)async{
     var querySnapshot=await getUserCollection().doc(uId).get();
     return querySnapshot.data();
  }
}