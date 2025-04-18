import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_admin/providers/meal_controller.dart';
import 'package:hostel_admin/views/MealItems.dart';

class Additems extends StatefulWidget {
  final String? day;
  const Additems({required this.day, super.key});

  @override
  State<Additems> createState() => _AdditemsState();
}

class _AdditemsState extends State<Additems> {
  final MealController controller = Get.find();
  List<String> meal = ["Breakfast", "Lunch", "Snacks", "Dinner"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                )),
            SizedBox(height: 20),
            Text(
              "Select the Items for ${widget.day}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GetBuilder<MealController>(
                builder: (_) {
                  return GridView.builder(
                    itemCount: meal.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 30,
                        childAspectRatio: 4),
                    itemBuilder: (context, index) {
                      final mealName = meal[index];
                      final done =
                          controller.isMealCompleted(widget.day!, mealName);

                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Additemsday(meal:mealName),
                            ),
                          );
                          if (result != null && result is List<String>) {
                            controller.setMeal(widget.day!, mealName, result);
                            await controller
                                .add_data(widget.day!); // sync to backend
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(mealName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              !done
                                  ? Icon(Icons.arrow_forward_outlined,
                                      color: Colors.white)
                                  : Icon(Icons.check_circle_outlined,
                                      color: Colors.green),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 20),
            // Submit Button
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (controller.isDayCompleted(widget.day!)) {
                    Navigator.pop(context);
                  } else {
                    ElegantNotification.info(
                      
                      height: 100,
                      width: 250,
                      title: Text("Info"),
                      description:
                          Text("Fill Items to Continue"),
                      icon: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.black,
                      ),

                    ).show(context);
                  }
                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Center(
                      child:
                          Text("Submit", style: TextStyle(color: Colors.white,fontSize: 20)),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
