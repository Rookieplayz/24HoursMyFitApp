import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/Authentication/UI/RegisterPage.dart';
import 'package:twenty_four_hours/MyFit/Models/Exercise.dart';

class ExcersiseHandling
{
  
 
  final String path;
  ExcersiseHandling({this.path="24HTeam"});
  

  DatabaseReference ref=FirebaseDatabase.instance.reference();

  Future<void> saveExcercise(Exercise exercise)
  async {
    
   await ref.child("Exercises").child("/$path").child(exercise.id.toString()).push().set(exercise.toJson());
  }

  Future<StreamSubscription<Event>> getExerciseStream(void onData(Exercise exercise))async{
     StreamSubscription<Event>main_subscription;//FirebaseDatabase.instance
   print("><><><><><><><><><><>");
   List<UIDs>uids=new List<UIDs>();
    StreamSubscription<Event>subscription=FirebaseDatabase.instance
    .reference()
    .child("Exercises")
    .child(path)
    .onChildAdded
    .listen((e){
      UIDs uid=UIDs.fromSnapshot(e.snapshot);
    //  print(uid.uid);
       main_subscription=FirebaseDatabase.instance
       .reference()
      .child("Exercises")
      .child(path)
      .child(uid.uid)
      .onChildAdded
      .listen((Event ev){
       print("Using current uid: ${uid.uid}");
      Exercise exercise=  Exercise.fromSnapshot(ev.snapshot);
      onData(exercise);
      print("Moving on...");
      });
      });
      


      /* main_subscription=FirebaseDatabase.instance
       .reference()
      .child("Exercises")
      .child(path)
      .child(uid.uid)
      .onChildAdded
      .listen((Event ev){
       
      Exercise exercise=  Exercise.fromSnapshot(ev.snapshot);
      onData(exercise); print(">>>>>\n$exercise");
      });*/

  
    return subscription;
  }
  
  
}