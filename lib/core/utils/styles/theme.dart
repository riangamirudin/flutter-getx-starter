import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_starter/core/utils/constants/value.dart';
import 'package:flutter_getx_starter/core/utils/styles/color.dart';
import 'package:flutter_getx_starter/core/utils/styles/text_style.dart';

ThemeData themeData = ThemeData(
  useMaterial3: true,
  fontFamily: "MyriadPro",
  primaryColor: primaryColor,
  primarySwatch: primaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationThemeData(
    filled: true,
    fillColor: fillInputColor,
    focusColor: fillInputColor,
    hoverColor: fillInputColor,
    enabledBorder: _defaultInputBorder,
    focusedBorder: _defaultInputBorder,
    errorBorder: _defaultErrorBorder,
    focusedErrorBorder: _defaultErrorBorder,
  ),
  appBarTheme: _appBarTheme,
  textTheme: appTextTheme,
  textButtonTheme: _textButtonThemeData,
  filledButtonTheme: _filledButtonThemeData,
  elevatedButtonTheme: _elevatedButtonThemeData,
);

InputBorder _defaultInputBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(SMALL_UI),
);

InputBorder _defaultErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: dangerColor),
  borderRadius: BorderRadius.circular(SMALL_UI),
);

AppBarTheme _appBarTheme = AppBarTheme(
  systemOverlayStyle: SystemUiOverlayStyle.light,
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: false,
  leadingWidth: 20 + ((BackButton().padding?.horizontal ?? 0) * 2) + (MEDIUM_UI * 2),
  actionsPadding: EdgeInsets.symmetric(horizontal: SMALL_UI),
);

TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(padding: EdgeInsets.all(SMALL_UI), overlayColor: primaryColor),
);

FilledButtonThemeData _filledButtonThemeData = FilledButtonThemeData(
  style: FilledButton.styleFrom(
    padding: EdgeInsets.all(SMALL_UI),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SMALL_RADIUS))),
  ),
);

ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: FilledButton.styleFrom(
    padding: EdgeInsets.all(SMALL_UI),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SMALL_RADIUS))),
  ),
);
