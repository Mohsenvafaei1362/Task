import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testproject/core/utils/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  scaffoldBackgroundColor: BACKGROUND_LIGHT_COLOR,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: APPBAR_BACKGROUND_LIGHT_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ),
    centerTitle: true,
    elevation: 1.0,
    backgroundColor: APPBAR_BACKGROUND_LIGHT_COLOR,
    iconTheme: const IconThemeData(color: COLOR_PRIMARY),
    titleTextStyle: TextStyle(color: COLOR_PRIMARY),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: TEXT_FIELD_BACKGROUND_LIGHT_COLOR,
    hintStyle: TextStyle(color: TEXT_FIELD_HINT_COLOR),
    contentPadding: const EdgeInsets.all(12),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: TEXT_FIELD_BORDER_LIGHT_COLOR),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: TEXT_FIELD_ENABLED_BORDER_LIGHT_COLOR,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorStyle: TextStyle(color: TEXT_MESSAGE_ERROR_COLOR),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: const BorderSide(color: TEXT_MESSAGE_ERROR_COLOR),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: const BorderSide(color: TEXT_MESSAGE_ERROR_COLOR),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? SWITCH_CHECKED_THUMB_COLOR
              : SWITCH_NOT_CHECKED_THUMB_COLOR,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? SWITCH_CHECKED_TRACK_COLOR
              : SWITCH_NOT_CHECKED_TRACK_COLOR,
    ),
  ),
  textTheme: TextTheme(labelLarge: TextStyle(fontSize: 12)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: COLOR_SECONDARY,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 12),
    selectedItemColor: COLOR_PRIMARY,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: BACKGROUND_DARK_COLOR,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: APPBAR_BACKGROUND_DARK_COLOR,
    ),
    centerTitle: true,
    elevation: 1.0,
    backgroundColor: APPBAR_BACKGROUND_DARK_COLOR,
    iconTheme: const IconThemeData(color: COLOR_PRIMARY),
    titleTextStyle: TextStyle(color: COLOR_PRIMARY),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: TEXT_FIELD_BACKGROUND_DARK_COLOR,
    hintStyle: TextStyle(color: TEXT_FIELD_HINT_COLOR),
    contentPadding: const EdgeInsets.all(12),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: TEXT_FIELD_BORDER_DARK_COLOR),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: TEXT_FIELD_ENABLED_BORDER_DARK_COLOR.withAlpha(70),
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorStyle: TextStyle(color: TEXT_MESSAGE_ERROR_COLOR),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: const BorderSide(color: TEXT_MESSAGE_ERROR_COLOR),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: const BorderSide(color: TEXT_MESSAGE_ERROR_COLOR),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? SWITCH_CHECKED_THUMB_COLOR
              : SWITCH_NOT_CHECKED_THUMB_COLOR,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected)
              ? SWITCH_CHECKED_TRACK_COLOR
              : SWITCH_NOT_CHECKED_TRACK_COLOR,
    ),
  ),
  textTheme: TextTheme(labelLarge: TextStyle(fontSize: 12)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: COLOR_SECONDARY,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 12),
    selectedItemColor: COLOR_PRIMARY,
  ),
);
