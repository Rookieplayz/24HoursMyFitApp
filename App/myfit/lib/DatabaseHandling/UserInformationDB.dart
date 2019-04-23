import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Authentication/auth.dart';
import 'package:twenty_four_hours/Main/Award.dart';
import 'package:twenty_four_hours/Main/Profile.dart';

class UserInformationDB{
  
  final String path;
  UserInformationDB({this.path=""});
  

  DatabaseReference ref=FirebaseDatabase.instance.reference();
  
  Future<void> saveUser(Register reg)
  async {
    FirebaseUser user= await FirebaseAuth.instance.currentUser();

   await ref.child("User_Information")
   .child("/${user.uid}")
   .push().set(reg.toJson());
  }

  Future<StreamSubscription<Event>> getUserInfo(void onData(Register reg))async{
      print("><USER_INFO<>");
 FirebaseUser user= await FirebaseAuth.instance.currentUser();

    StreamSubscription<Event>subscription=FirebaseDatabase.instance
    .reference()
    .child("/User_Information")
    .child("/${user.uid}")
    .onChildAdded
    .listen((e){
  
      Register reg=  Register.fromSnapshot(e.snapshot);
      onData(reg); print(">>>>>\n$reg");
    print("Comleted");
      });
    
    return subscription;
  }
  
}