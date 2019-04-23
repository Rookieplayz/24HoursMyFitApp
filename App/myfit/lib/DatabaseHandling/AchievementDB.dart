import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/Main/Award.dart';
import 'package:twenty_four_hours/Main/Profile.dart';

class AchievementsDB{
  
  final String path;
  final Profile p;
  AchievementsDB(this.p,{this.path=""});
  

  DatabaseReference ref=FirebaseDatabase.instance.reference();

  Future<void> saveAward(Award award)
  async {
    
   await ref.child("Profile")
   .child("/${p.userinformation.UID}")
   .child("/Achievements")
   .child("/$path")
   .push().set(award.toJson());
  }

  Future<StreamSubscription<Event>> getAwards(void onData(Award award))async{
      print("><><><><><><><><><><>");

    StreamSubscription<Event>subscription=FirebaseDatabase.instance
    .reference()
    .child("/${p.userinformation.UID}")
   .child("/Achievements")
   .child("/$path")
    .onChildAdded
    .listen((e){
  
      Award award=  Award.fromSnapshot(e.snapshot);
      onData(award); print(">>>>>\n$award");
    print("Comleted");
      });
    
    return subscription;
  }
  
}