import 'package:twenty_four_hours/Authentication/Model/Register.dart';

import 'package:twenty_four_hours/MyFit/Models/Cinema.dart';
import 'package:twenty_four_hours/MyFit/Models/Follows.dart';
import 'package:twenty_four_hours/MyFit/Models/Friends.dart';
import 'package:twenty_four_hours/MyFit/Models/Gallery.dart';
import 'package:twenty_four_hours/MyFit/Models/Workout.dart';
import 'package:twenty_four_hours/MyFit/Models/WorkoutPlans.dart';
import 'package:twenty_four_hours/MyFit/Models/MealPlans.dart';
class MyFitProfile {
  Register _user = new Register();
  Follows _follow = new Follows();
  String _UID = '';
  Gallery gallery = new Gallery();

  Friends _friends;
  String _bio = 'Hey There!, Welcome to MyFit Profile';
  List<Gallery> savedPictures;
  List<Workout>savedWorkouts=new List<Workout>();
  List<WorkoutPlan>savedWorkoutPlans;
  List<MealPlan>savedMealPlans;
  List<Workout>completedWorkouts;
  List<WorkoutPlan>completedWorkoutPlans;

  List<Workout>publicWorkouts=new List<Workout>();
  List<WorkoutPlan>publicWorkoutPlans=new List<WorkoutPlan>();

  List<Workout>privateWorkouts=new List<Workout>();
  List<WorkoutPlan>privateWorkoutPlans=new List<WorkoutPlan>();


  WorkoutPlan currentWorkoutPlan;
  WoroutStats workoutStats;



  Cinema cinema;

  MyFitProfile(
      [this._user,
      this._UID,
      this._follow,
      this._bio,
      this.gallery,
      this._friends,
      this.cinema,
      this.savedWorkouts]){savedWorkouts=new List<Workout>();}


  Friends get friends => _friends;

  set friends(Friends value) {
    _friends = value;
  }

  String get bio => _bio;

  set bio(String value) {
    _bio = value;
  }

  Follows get follow => _follow;

  set follow(Follows value) {
    _follow = value;
  }

  String get UID => _UID;

  set UID(String value) {
    _UID = value;
  }

  Register get user => _user;

  set user(Register value) {
    _user = value;
  }

  @override
  String toString() {
    return 'Profile{ _follow: $_follow, _UID: $_UID, gallery: $gallery, _friends: $_friends, _bio: $_bio, savedPictures: $savedPictures}';
  }
}
class WoroutStats{
  double averageKcal;
  double currentWeight;
  String favouriteMuscle;
  int strengthLvl;

  WoroutStats({this.averageKcal=0.0, this.currentWeight=0.0, this.favouriteMuscle='',this.strengthLvl=0});


}