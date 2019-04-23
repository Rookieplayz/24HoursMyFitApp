import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
class Meal {
  String _name = '';
  int kcal = 0;
  String id=new Uuid().v1();
  Nutrients nutrients = new Nutrients();
  List<dynamic> incredients = List<String>();
  List<dynamic> recipie = List<String>();
  String prep = '';

  Meal(this._name,
      {this.kcal, this.nutrients, this.incredients, this.recipie, this.prep});

  
Meal.fromSnapshot(DataSnapshot s)
  :_name=s.value['name'],
  kcal=s.value['calories'],
  id=s.value['id'],
 nutrients=s.value['nutrients'],
  incredients=s.value['incredients'],
  recipie=s.value['recipie'],
  prep=s.value['prep'];

  toJson(){
   
    return{
      'name':_name,
      'calories':kcal,
      'id':id,
      'nutrients':nutrients.toJson(),
      'incredients':incredients,
      'recipie':recipie,
      'prep':prep,

    };
  }

}

class Nutrients {
  double carbs = 0.0;
  double protein = 0.0;
  double fats = 0.0;
  double water = 0.0;
  List<String> vitamins = new List<String>();
  int energy = 0;
  int calcium = 0;
  int sodium = 0;
  int potassium = 0;
  double fibre = 0.0;
  double salt = 0.0;

  Nutrients(
      {this.carbs,
      this.protein,
      this.fats,
      this.water,
      this.vitamins,
      this.energy,
      this.calcium,
      this.sodium,
      this.potassium,
      this.fibre,
      this.salt});

Nutrients.fromSnapshot(DataSnapshot s)
  :   carbs=s.value['carbs'],
      protein=s.value['protein'],
      fats=s.value['fats'],
      water=s.value['water'],
      vitamins=s.value['vitamins'],
      energy=s.value['energy'],
      calcium=s.value['calcium'],
      sodium=s.value['sodium'],
      potassium=s.value['potassium'],
      fibre=s.value['fibre'],
      salt=s.value['salt'];

  toJson(){
   
    return{
      'carbs':carbs,
      'protein':protein,
      'fats':fats,
      'water':water,
      'vitamins':vitamins,
      'energy':energy,
      'calcium':calcium,
      'sodium':sodium,
      'potassium':potassium,
      'fibre':fibre,
      'salt':salt

    };
  }
  @override
  String toString() {
    return 'Nutrients{carbs: $carbs, protein: $protein, fats: $fats, water: $water, vitamins: $vitamins, energy: $energy, calcium: $calcium, sodium: $sodium, potassium: $potassium, fibre: $fibre, salt: $salt}';
  }
}
