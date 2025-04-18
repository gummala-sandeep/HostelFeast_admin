import 'package:flutter/material.dart';
import 'package:hostel_admin/views/homepage.dart';

class Loginpage extends StatelessWidget {

   
   Loginpage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
       mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    color:colorTheme.primary,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your credentials to continue",
                  style: TextStyle(
                    color: Color.fromARGB(255, 152, 152, 152),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                SizedBox(
                  height: 52,
                  child: TextField(
                    
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, color: const Color.fromARGB(255, 180, 180, 180),),
                      label: Text("Email"),
                      labelStyle: TextStyle(
                        color: colorTheme.primary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorTheme.onSurface
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorTheme.onSurface
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 52,
                  child: TextField(
                   
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: const Color.fromARGB(255, 180, 180, 180),),
                      label: Text("Password"),
                      labelStyle: TextStyle(
                        color: colorTheme.primary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorTheme.onSurface
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorTheme.onSurface
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // errorMessage != "" ? Text(errorMessage!, style: TextStyle(
                //   color: Colors.red,
                // ),) : SizedBox(height: 0,),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage())),
                  child: Container(
                        width: MediaQuery.of(context).size.width - 36,
                        height: 52,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top : 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Text("Continue", style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}