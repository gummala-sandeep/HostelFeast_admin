import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_admin/main.dart';
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
                      color:Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color:Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    days[DateTime.now().weekday - 1],
                    style: TextStyle(
                      color:Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  height:Width>700?200: 150,
                  
                  width:Width>700?Width*0.4: MediaQuery.sizeOf(context).width * 0.8,
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
                      crossAxisCount: Width>700?2:1,
                      crossAxisSpacing: 20,
                      childAspectRatio: Width>700?8:4,
                      mainAxisSpacing: 12,
                      
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
                            gradient: LinearGradient(colors: 
                            [
                              const Color.fromARGB(255, 29, 29, 29),
                              const Color.fromARGB(255, 67, 67, 67)
                            ])
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
