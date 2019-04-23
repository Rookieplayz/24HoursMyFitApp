import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/MyFit/Models/MealPlans.dart';
import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';
import 'package:twenty_four_hours/MyFit/Models/Workout.dart';
import 'package:uuid/uuid.dart';
class WorkoutPlan {
  String id=Uuid().v1();
  List<Workout> _workouts = new List<Workout>();
  List<MealScheduler> _mealPlans;
  bool isActive = false;
  bool hasStarted = false;
  bool isDownloaded=false;
  String creatorId = '';
  DateTime dateCreated = new DateTime.now();
  int rating = 0;
  String description = '';
  String level = '';
  int duration =30;
  int currentDay=0;
  DateTime startOn = new DateTime.now();
  List<dynamic> tags = List<String>();

  WorkoutPlan([
    this._workouts,
    this._mealPlans,
    this.isActive,
    this.hasStarted,
    this.isDownloaded,
    this.creatorId,
    this.dateCreated,
    this.rating,
    this.description,
    this.level,
    this.duration,
    this.currentDay,
    this.startOn,
    this.tags
  ]);

  WorkoutPlan.fromSnapshot(DataSnapshot s)
  : id=s.value['id'],
    _workouts=s.value['Workouts'],
    _mealPlans=s.value['MealPlan'],
    isActive=s.value["active"],
    hasStarted=s.value["started"],
    isDownloaded=s.value["downloaded"],
    creatorId=s.value["creatorId"],
    dateCreated=new DateTime.fromMillisecondsSinceEpoch(
            s.value["date_created"]),
    rating=s.value["rating"],
    description=s.value["description"],
    level=s.value["level"],
    duration=s.value["Duration"],
    currentDay=s.value["CurrentDay"],
    startOn=s.value["StartOn"],
    tags=s.value["tags"];

    toJson()
    {
      List<dynamic> workouList=new List<dynamic>();
      for(Workout w in _workouts)
      {
        workouList.add(w.toJson());
      }
      List<dynamic> mealList=new List<dynamic>();
      for(MealScheduler m in _mealPlans)
      {
        mealList.add(m.toJson());
      }
      return{
        'id':id,
        'Workouts':workouList,
        'MealPlan':mealList,
        'active':isActive,
        'started':hasStarted,
        'downloaded':isDownloaded,
        'creatorId':creatorId,
        'date_created':dateCreated.millisecondsSinceEpoch,
        'rating':rating,
        'description':description,
        'level':level,
        'Duration':duration,
        'CurrentDay':currentDay,
        'StartOn':startOn,
        'tags':tags
      };
    }
}
