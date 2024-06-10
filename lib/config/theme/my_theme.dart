import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff3598DB);
  static Color primaryDarkColor = const Color(0xff060E1E);
  static Color blackColor = const Color(0xff141922);
  static Color greyColor = const Color(0xffC8C9CB);
  static Color darkGreyColor = const Color(0xff707070);
  static Color greenColor = const Color(0xff61E757);
  static Color redColor = const Color(0xffEC4B4B);
  static Color backgroundColor = const Color(0xffDFECDB);

  static ThemeData lightMode = ThemeData(
      colorScheme: ColorScheme.light(primary: primaryColor),
      primaryColor: primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          backgroundColor: Colors.transparent,
          elevation: 0
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
          shape: const StadiumBorder(
              side: BorderSide(
            color: Colors.white,
            width: 3,
              strokeAlign: 2
          )
        )
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: blackColor,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        labelSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: blackColor,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: greyColor,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
  static ThemeData darkMode = ThemeData(
      colorScheme: ColorScheme.dark(primary: primaryColor),
      primaryColor: primaryColor,
      bottomNavigationBarTheme:
      BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0 ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          shape: StadiumBorder(
              side: BorderSide(
                  color: blackColor,
                  width: 3,
                strokeAlign: 2
              )
          )
      ),
      scaffoldBackgroundColor: primaryDarkColor,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        titleSmall: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        labelSmall: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: greyColor,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
}