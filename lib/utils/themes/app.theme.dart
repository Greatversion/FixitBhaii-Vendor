import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  // Light Theme for the app
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        cardTheme: CardTheme(
          color: const Color.fromARGB(255, 225, 223, 223),
        ),
        primaryColor: AppColors.electricBlue,
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          elevation: 0,
          backgroundColor: AppColors.electricBlue,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        dividerColor: Colors.black,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          displayMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          displaySmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          bodyLarge: TextStyle(fontSize: 18, color: AppColors.black),
          bodyMedium: TextStyle(fontSize: 16, color: AppColors.black),
          bodySmall: TextStyle(fontSize: 14, color: AppColors.black),
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.electricBlue,
          secondary: AppColors.orange,
          onPrimary: AppColors.white,
          onSecondary: AppColors.black,
          onSurface: AppColors.black,
          error: AppColors.errorRed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.electricBlue,
            foregroundColor: AppColors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.electricBlue),
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.electricBlue),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
          ),
        ),
      );

  // Dark Theme for the app
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        cardTheme: CardTheme(
          color: AppColors.textPrimary,
        ),
        primaryColor: AppColors.electricBlue, // Darker shade for night mode
        fontFamily: 'Nunito',
        dividerColor: Colors.white24,
        scaffoldBackgroundColor: AppColors.backgroundDark, // Dark background
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.white, // White text for contrast
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.backgroundDark, // Darker appbar background
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white),
          displayMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white),
          displaySmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white),
          bodyLarge: TextStyle(fontSize: 18, color: AppColors.white),
          bodyMedium: TextStyle(fontSize: 16, color: AppColors.white),
          bodySmall: TextStyle(fontSize: 14, color: AppColors.white),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.electricBlue,
          secondary: AppColors.infoBlue,
          onPrimary: AppColors.white,
          onSecondary: AppColors.darkGray,
          onSurface: AppColors.white,
          error: AppColors.errorRed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.electricBlue, // Dark theme button
            foregroundColor: AppColors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.red),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkGray),
          ),
        ),
      );
}
