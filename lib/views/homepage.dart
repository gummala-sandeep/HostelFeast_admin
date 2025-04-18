import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_admin/providers/meal_controller.dart';
import 'package:hostel_admin/views/DayItems.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final int noOfStudents = 80;
    List<String> days = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTime.now().hour < 12
                        ? "Good Morning"
                        : (DateTime.now().hour < 15
                            ? "Good Afternoon"
                            : "Good Evening"),
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.menu),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${DateTime.now().day} March ${DateTime.now().year}",
                    style: TextStyle(
                      color: colorTheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: colorTheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    days[DateTime.now().weekday - 1],
                    style: TextStyle(
                      color: colorTheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  
                    ),
                  
                  child: Center(
                    child: Text(
                      "Total No of Students Attending The Meal:\n $noOfStudents",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        wordSpacing: 2,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Select a Day To Fill the Meal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 30),
              GetBuilder<MealController>(
                builder: (controller) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      
                      mainAxisSpacing: 12,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      final day = days[index];
                      final isDone = controller.isDayCompleted(day);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Additems(day: day),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  day,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                !isDone? Icon(Icons.arrow_forward_outlined,color: Colors.white,):Icon(Icons.check_circle_outlined,color:Colors.green), 
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
