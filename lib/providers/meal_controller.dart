import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MealController extends GetxController{
    var selecteditems=<String,Map<String,List<String>>>{}.obs;

    bool isMealCompleted(String day,String meal){
      return selecteditems[day]?[meal]?.isNotEmpty??false;
    }

    bool isDayCompleted(String day){
      var meals=selecteditems[day];
      return meals!=null&&
        meals.containsKey("Breakfast")&&          
        meals.containsKey("Lunch")&&
        meals.containsKey("Snacks")&&
        meals.containsKey("Dinner")&&
        meals["Breakfast"]!.isNotEmpty&&        
        meals["Lunch"]!.isNotEmpty&&
        meals["Snacks"]!.isNotEmpty&&
        meals["Dinner"]!.isNotEmpty;
    }
    
     void setMeal(String day, String meal, List<String> items) {
    if (!selecteditems.containsKey(day)) {
      selecteditems[day] = {};
    }
    selecteditems[day]![meal] = items;
    update(); // Trigger UI update
  }

    
    Future<void> add_data(String day) async{
      if(!selecteditems.containsKey(day)) return;
      var data=selecteditems[day];
      if(data==null){
        return ;
      }
      await FirebaseFirestore.instance.collection("Weekly Menu").doc(day).set(data);
    }
}
