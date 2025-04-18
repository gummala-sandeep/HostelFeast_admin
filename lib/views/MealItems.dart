import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Additemsday extends StatefulWidget {
  final String? meal;
  const Additemsday({required this.meal, super.key});

  @override
  State<Additemsday> createState() => _AdditemsdayState();
}

class _AdditemsdayState extends State<Additemsday> {
  List<String> items = [];
  List<String> selecteditems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getitems();
  }

  void getitems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Food Items")
        .doc((widget.meal == "Lunch") ? "Dinner" : widget.meal)
        .get();
    final data = snapshot.data();
    if (data != null && data['items'] != null) {
      final List<dynamic> rawList = data['items'];
      setState(() {
        items = rawList.map((item) => item.toString()).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = ((items.length / 2).ceil()) * 172;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_outlined),
                    iconSize: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${widget.meal}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: isLoading
                    ? SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: height,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,                        ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            bool isSelected =
                                selecteditems.contains(items[index]);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selecteditems.remove(items[index]);
                                  } else {
                                    selecteditems.add(items[index]);
                                  }
                                });
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.green
                                                : Colors.transparent,
                                            width: 3,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://res.cloudinary.com/dvlnqyghc/image/upload/v1744569253/${items[index]}.png",
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    const Color.fromARGB(
                                                        255, 201, 201, 201)!,
                                                child: Container(
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        items[index],
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 22,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            if (selecteditems.isNotEmpty) {
              Navigator.pop(context, selecteditems);
            } else {
              ElegantNotification.info(
                height: 100,
                width: 250,
                title: Text("Info"),
                description: Text("Fill items to Submit."),
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.black,
                ),
              ).show(context);
            }
          },
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
