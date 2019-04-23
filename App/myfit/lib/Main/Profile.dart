import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';

import 'dart:math';
class Profile{
  Register userinformation=null;
  int Xp=1;
  int level=1;
  Profile({this.userinformation});
  
  void increaseXp(int val)
  {
    
    this.Xp+=val;
    
    
  }
  void levelUp()
  {
    this.level=this.level++;
  }
}