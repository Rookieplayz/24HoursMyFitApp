import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/MyFit/Models/Meal.dart';
import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';
import 'package:uuid/uuid.dart';
class MealSchedule{
  Meal breakfast;
  Meal lunch;
  Meal dinner;
  Meal snack;

  MealSchedule.fromJson(DataSnapshot s)
  : breakfast=s.value["breakfast"],
    lunch=s.value["lunch"],
    dinner=s.value["dinner"],
    snack=s.value["snack"];
  toJson(){
    return {
      'breakfast':breakfast.toJson(),
      'lunch':lunch.toJson(),
      'dinner':lunch.toJson(),
      'snack':lunch.toJson()
    };
  }

}
class MealScheduler
{
  int day=1;
  MealSchedule mealSchedule;

  MealScheduler([this.day,this.mealSchedule]);
  
  MealScheduler.fromSnapshot(DataSnapshot s)
  : day=s.value['Day'],
    mealSchedule=s.value['Meal_Schedule'];

  toJson()
  {
    return {
      'Day':day,
      'Meal_Schedule':mealSchedule.toJson()
    };
  }
}
class MealPlan {
  MealScheduler meals;// <day, meals>
  String id= new Uuid().v1();
  int breakfast_time = 9;
  int lunch_time =  13;
  int dinner_time =19;
  int length = 30;
  DateTime dateCreated = new DateTime.now();
  String _name = '';
  List<dynamic> dietType = List<String>();
  List<dynamic> tags = List<String>();
  String creatorId = '';
  String tip = '';

  MealPlan(this._name,
      {
      this.breakfast_time,
      this.lunch_time,
      this.dinner_time,
      this.length,
      this.dateCreated,
      this.dietType,
      this.creatorId,
      this.tags,
      this.tip});

MealPlan.fromSnapshot(DataSnapshot s)
: _name=s.value['name'],
id=s.value['id'],
length=s.value['length_Of_Plan'],
dinner_time=s.value['dinner_time'],
lunch_time=s.value['lunch_time'],
breakfast_time=s.value['breakfast_time'],
 dateCreated = new DateTime.fromMillisecondsSinceEpoch(
            s.value["date_created"]),
dietType=s.value['dietType'],
tags=s.value['tags'],
tip=s.value['tips'],
creatorId=s.value['creatorId'],
meals=s.value['meals'];

toJson()
{
  return{
    'name':_name,
    'id':id,
    'length_Of_Plan':length,
    'dinner_time':dinner_time,
    'lunch_time':lunch_time,
    'breakfast_time':breakfast_time,
    'date_created':dateCreated.millisecondsSinceEpoch,
    'dietType':dietType,
    'creatorId':creatorId,
    'tags':tags,
    'tips':tip,
    'meals':meals.toJson()

  };
}




  @override
  String toString() {
    return 'MealPlan{ breakfast_time: $breakfast_time, lunch_time: $lunch_time, dinner_time: $dinner_time, length: $length, dateCreated: $dateCreated, _name: $_name, type: $dietType, tags: $tags, tip: $tip}';
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
