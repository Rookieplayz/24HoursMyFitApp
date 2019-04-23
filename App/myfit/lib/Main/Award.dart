import 'package:firebase_database/firebase_database.dart';
import 'package:twenty_four_hours/DatabaseHandling/AchievementDB.dart';
import 'package:twenty_four_hours/Main/Profile.dart';

enum Grade{BRONZE,GOLD,SILVER}
enum AwardType{GYM,LIFESTYLE,EDUCATION}

 class Award
{

  Grade grade=Grade.BRONZE;
  AwardType awardType=AwardType.GYM;
  String description='';
  DateTime dateEarned=DateTime.now();
  bool earned=false;
  String name='';
  String icon='';
  int XPbonus=0;
  
  
  Award([
    this.name,
    this.grade,
    this.awardType,
    this.description,
    this.icon,
    this.earned,
    
    this.XPbonus
  ]);

  void unlock(Award a, Profile p)
  {
    a.earned=true;
    p.increaseXp(a.XPbonus);
    
    
    //save to Database 
    AchievementsDB(p,path: awardType.toString().split('.').last).saveAward(a);

  }

  Award.fromSnapshot(DataSnapshot s)
  :grade=Grade.values.firstWhere((e) => e.toString() == s.value['Grade']),
    awardType=AwardType.values.firstWhere((e)=>e.toString()==s.value['AwardType']),
    description=s.value['decription'],
    dateEarned=new DateTime.fromMillisecondsSinceEpoch(
            s.value["date_earned"]),
    earned=s.value['earned'],
    name=s.value['name'],
    icon=s.value['icon'],
    XPbonus=s.value['xpBonus'];

  toJson()
  {
    return{
      'Grade':grade.toString().split('.').last,
      'AwardType':awardType.toString().split('.').last,
      'description':description,
      'date_earned':dateEarned.millisecondsSinceEpoch,
      'earned':earned,
      'name':name,
      'icon':icon,
      'xpBonus':XPbonus
    };
  }



}