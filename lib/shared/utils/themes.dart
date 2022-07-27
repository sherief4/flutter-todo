import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/shared/utils/constants.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: myGreen,
  primarySwatch: Colors.green,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black.withOpacity(.9),
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: darkBackgroundColor,
  primaryColor: myGreen,
  primarySwatch: Colors.green,
  appBarTheme: AppBarTheme(
    backgroundColor: darkBackgroundColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: darkBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0.7,
    titleTextStyle: TextStyle(
      color: Colors.white.withOpacity(.9),
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
