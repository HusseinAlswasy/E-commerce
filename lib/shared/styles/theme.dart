import 'package:e_commerce/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme =  ThemeData(
    primarySwatch:deafultcolor,
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('404040'),
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('404040'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
    scaffoldBackgroundColor: HexColor('404040'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: deafultcolor,
      unselectedItemColor: Colors.grey,
      elevation: 100,
      backgroundColor: HexColor('404040'),
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ) //override عليه
    ),
    fontFamily: 'Flu',
);

ThemeData lightTheme = ThemeData(
    primarySwatch:deafultcolor,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: deafultcolor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Flu'
      ),
      iconTheme: IconThemeData(
        color: deafultcolor,
        size: 25,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: deafultcolor,
      unselectedItemColor: Colors.grey,
      elevation: 100,
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
    fontFamily: 'Flu',

);

