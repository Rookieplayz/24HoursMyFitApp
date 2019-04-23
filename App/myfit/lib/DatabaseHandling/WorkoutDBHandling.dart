import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/Authentication/UI/RegisterPage.dart';
import 'package:twenty_four_hours/MyFit/Models/Workout.dart';
import 'package:twenty_four_hours/MyFit/Models/Workout.dart';

class WorkoutDBHandling
{
  
 
  final String path;
  WorkoutDBHandling({this.path="24HTeam"});
  

  DatabaseReference ref=FirebaseDatabase.instance.reference();

  Future<void> saveWorkout(Workout workout)
  async {
    
   await ref.child("Workouts").child("/$path").child(workout.id.toString()).push().set(workout.toJson());
  }

  Future<StreamSubscription<Event>> getWorkoutStream(void onData(Workout workout))async{
     StreamSubscription<Event>main_subscription;//FirebaseDatabase.instance
   
    StreamSubscription<Event>subscription=FirebaseDatabase.instance
    .reference()
    .child("Workouts")
    .child(path)
    .onChildAdded
    .listen((e){
      UIDs uid=UIDs.fromSnapshot(e.snapshot);
      print(uid.uid);
       main_subscription=FirebaseDatabase.instance
       .reference()
      .child("Workouts")
      .child(path)
      .child(uid.toString())
      .onChildAdded
      .listen((Event ev){
       
      Workout workout=  Workout.fromSnapshot(ev.snapshot);
      onData(workout); print(workout);
      });

   
    });
    return main_subscription;
  }
  
  
}