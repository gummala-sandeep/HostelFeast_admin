import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme() {
  const backgroundColor = Color(0XFFFFFFFF);
  const primaryColor = Color(0XFF101010); 
  const secondaryColor = Color(0XFFA100FF);
  const secondaryTextColor = Color(0XFF595959);
  const surfaceColor = Color(0XFFEFEFEF);

  return ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor, 
      secondary: secondaryColor,
      onPrimary: primaryColor,
      onSecondary: secondaryTextColor,  
      surface: backgroundColor,
      onSurface: surfaceColor,
    ),



    
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme.copyWith(
        displayLarge: const TextStyle(color: primaryColor),
        displayMedium: const TextStyle(color: primaryColor),
        displaySmall: const TextStyle(color : primaryColor),        
        headlineLarge: const TextStyle(color : primaryColor),
        headlineMedium: const TextStyle(color : primaryColor),
        headlineSmall: const TextStyle(color : primaryColor),
        titleLarge: const TextStyle(color : primaryColor),
        titleMedium: const TextStyle(color : primaryColor),
        titleSmall: const TextStyle(color : primaryColor),
        bodyLarge: const TextStyle(color : primaryColor),
        bodyMedium: const TextStyle(color : primaryColor),
        bodySmall: const TextStyle(color : primaryColor),
      )
    )
    
  );
}


