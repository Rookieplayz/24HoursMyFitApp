import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/MyFit/Models/Exercise.dart';
import 'package:twenty_four_hours/MyFit/Models/MyFit_Profile.dart';
import 'package:uuid/uuid.dart';
class Workout {
  List<Exercise> exercises = List<Exercise>();
  //Map<String,Exercise> exercises;
  
  String name = '';
  String id=new Uuid().v1();
  String imgUrl='';
  String level = '';
  String creatorId = '';
  String desc = '';
  int rating = 0;
  List<Superset> superset =[new Superset()];
  List<String>muscles=new List<String>();

  

Workout.fromSnapshot(DataSnapshot s)
  :exercises=s.value['exercises'],
  name=s.value['name'],
  id=s.value['id'],
  imgUrl=s.value['imgUrl'],
  level=s.value['level'],
  creatorId=s.value['creatorId'],
  desc=s.value['description'],
  rating=s.value['rating'],
  superset=s.value['superset'],
  muscles=s.value['muscles'];

  toJson(){
    List<dynamic> exes=new List<dynamic>();
    for(Exercise e in exercises)
    {
    
      exes.add(e.toJson());
    }
      List<dynamic> s_exes=new List<dynamic>();
    for(Exercise e in exercises)
    {
     
      s_exes.add(e.toJson());
    }
    return{
      'name':name,
      'exercises':exes,
      'id':id,
      'imgUrl':imgUrl,
      'level':level,
      'creatorId':creatorId,
      'description':desc,
      'rating':rating,
      'superset':superset!=null?s_exes:null,
      'muscles':muscles

    };

  }

  Workout(this.creatorId,
  [
    this.exercises,
    this.name,
    this.imgUrl,
    this.level,
    this.desc,
    this.rating,
    this.superset]);


  @override
  String toString() {
    return 'Workout{exercises: $exercises, name: $name, id: $id, imgUrl: $imgUrl, level: $level, creator: $creatorId, desc: $desc, rating: $rating, superset: $superset}';
  }


}

class Superset {
  Exercise _first = new Exercise();
  Exercise _second = new Exercise();

  Superset([this._first, this._second]);

  Exercise get second => _second;

  set second(Exercise value) {
    _second = value;
  }

  Exercise get first => _first;

  set first(Exercise value) {
    _first = value;
  }
  Superset.fromSnapshot(DataSnapshot s)
  :_first=s.value['first_exercise'],
  _second=s.value['second_exercise'];

  toJson(){
    return{
      'first_exercise':_first.toJson(),
      'second_exercise':_second.toJson(),

    };

  }

  @override
  String toString() {
    return 'Superset{_first: $_first, _second: $_second}';
  }
}
