// import 'package:flutter/material.dart';

// class MyThemeApp {
//   static Color primaryColor = const Color(0xff5D9CEC);
//   static Color whiteColor = const Color(0xffffffff);
//   static Color blackColor = const Color(0xff383838);
//   static Color greenColor = const Color(0xff61E757);
//   static Color grayColor = const Color(0xff958b8b);
//   static Color redColor = const Color(0xffEC4B4B);
//   static Color backgroundLigtColor = const Color(0xffDFECDB);
//   static Color blueLigtColor = Color.fromARGB(255, 25, 77, 173);
//   static Color backgroundDarkColor = const Color(0xff060E1E);
//   static Color blackDarkColor = const Color(0xff141922);
//   static ThemeData ligtTheme = ThemeData(
//     primaryColor: primaryColor,
//     scaffoldBackgroundColor: backgroundLigtColor,
//     appBarTheme: AppBarTheme(
//       backgroundColor: primaryColor,
//       elevation: 0.0,
//     ),
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       selectedItemColor: primaryColor,
//       unselectedItemColor: grayColor,
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//     ),
//     bottomSheetTheme: BottomSheetThemeData(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//           side: BorderSide(
//             color: primaryColor,
//             width: 4,
//           )),
//     ),
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: primaryColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(35),
//         side: BorderSide(
//           color: whiteColor,
//           width: 3.0,
//         ),
//       ),
//     ),
//     textTheme: TextTheme(
//         titleLarge: TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//           color: whiteColor,
//         ),
//         titleMedium: TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//           color: blackColor,
//         ),
//         titleSmall: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: blackColor,
//         )),
//   );
//   static ThemeData darkTheme = ThemeData();
// }

import 'package:flutter/material.dart';

class MyThemeApp {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff383838);
  static Color greenColor = const Color(0xff61E757);
  static Color grayColor = const Color(0xff958b8b);
  static Color redColor = const Color(0xffEC4B4B);
  static Color backgroundLigtColor = const Color(0xffDFECDB);
  static Color blueLigtColor = Color.fromARGB(255, 25, 77, 173);
  static Color backgroundDarkColor = const Color(0xff060E1E);
  static Color blackDarkColor = const Color(0xff141922);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLigtColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: grayColor,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            color: primaryColor,
            width: 4,
          )),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(
          color: whiteColor,
          width: 3.0,
        ),
      ),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: blackColor,
        )),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDarkColor,
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: grayColor,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: primaryColor,
          width: 4,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(
          color: whiteColor,
          width: 3.0,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    ),
  );
}
