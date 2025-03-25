import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Colors.white;
const scaffoldBackgroundColor = Colors.black26;

const colorList = <Color> [
  Colors.blue,
  Colors.blueAccent,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
  Colors.grey,
  Colors.black
];

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false
  });
  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    //colorSchemeSeed: const Color.fromARGB(255, 35, 45, 66),
    colorSchemeSeed: colorList[2],
    
    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold , 
        //color: isDarkMode ? Colors.white : Colors.black, 
        ),
      titleMedium: GoogleFonts.roboto()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold , 
        //color: isDarkMode ? Colors.white : Colors.black,
        ),
      titleSmall: GoogleFonts.roboto()
        .copyWith( fontSize: 20 , 
        //color: isDarkMode ? Colors.white : Colors.black,
        )
    ),

    ///* Scaffold Background Color
    //scaffoldBackgroundColor: scaffoldBackgroundColor[300], 

    // ///* Buttons
    // filledButtonTheme: FilledButtonThemeData(
    //   style: ButtonStyle(
    //     textStyle: WidgetStatePropertyAll(
    //       GoogleFonts.montserratAlternates()
    //         .copyWith(fontWeight: FontWeight.w700)
    //       )
    //   )
    // ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      color: colorList[2],
      centerTitle: false,
      titleTextStyle: GoogleFonts.roboto()
        .copyWith( fontSize: 25, 
        fontWeight: FontWeight.bold, 
        // color: Colors.black 
        color: isDarkMode ? Colors.white : Colors.black,
        ),
    )
  );

  AppTheme copyWith({
    bool? isDarkMode
  }) => AppTheme(
    isDarkMode: isDarkMode ?? this.isDarkMode
  );

}