import 'package:flutter/material.dart';

const int blackPrimaryColor = 0xFF000000;
const int greenSuccessColor = 0xFF28A745;
const int yellowWarningColor = 0xFFFFC107;
const int redDangerColor = 0xFFDC3545;
const int purplerInfoColor = 0xFF6F42C1;

// Utils
Color borderColor = primaryColor.shade200;
Color disabledColor = primaryColor.shade200;
Color fillInputColor = primaryColor.shade200;
Color placeholderColor = Colors.grey;

// primary
const MaterialColor primaryColor = MaterialColor(blackPrimaryColor, {
  50: Color(0xFFFAFAFA), // hampir putih
  100: Color(0xFFF5F5F5),
  200: Color(0xFFEEEEEE),
  300: Color(0xFFE0E0E0),
  400: Color(0xFFBDBDBD),
  500: Color(blackPrimaryColor), // warna utama hitam
  600: Color(0xFF212121),
  700: Color(0xFF1B1B1B),
  800: Color(0xFF141414),
  900: Color(0xFF0A0A0A),
});

// success
const MaterialColor successColor = MaterialColor(greenSuccessColor, {
  50: Color(0xFFE6F4EA), // hijau sangat muda
  100: Color(0xFFC1E3CA),
  200: Color(0xFF97D1A8),
  300: Color(0xFF6DBF86),
  400: Color(0xFF4FB26D),
  500: Color(greenSuccessColor), // warna utama success
  600: Color(0xFF23963D),
  700: Color(0xFF1D8C36),
  800: Color(0xFF17812F),
  900: Color(0xFF0D6E24), // hi
});

// warning
const MaterialColor warningColor = MaterialColor(yellowWarningColor, {
  50: Color(0xFFFFF8E1),
  100: Color(0xFFFFECB3),
  200: Color(0xFFFFE082),
  300: Color(0xFFFFD54F),
  400: Color(0xFFFFCA28),
  500: Color(yellowWarningColor),
  600: Color(0xFFFFB300),
  700: Color(0xFFFFA000),
  800: Color(0xFFFF8F00),
  900: Color(0xFFFF6F00),
});

// danger
const MaterialColor dangerColor = MaterialColor(redDangerColor, {
  50: Color(0xFFFDECEA),
  100: Color(0xFFF9D3CE),
  200: Color(0xFFF3AFA6),
  300: Color(0xFFEC8B7D),
  400: Color(0xFFE87061),
  500: Color(redDangerColor),
  600: Color(0xFFD02F3E),
  700: Color(0xFFC32836),
  800: Color(0xFFB6222E),
  900: Color(0xFFA31620),
});

// info
const MaterialColor infoColor = MaterialColor(purplerInfoColor, {
  50: Color(0xFFF3EFFE),
  100: Color(0xFFE1D4FA),
  200: Color(0xFFCBB5F6),
  300: Color(0xFFB496F2),
  400: Color(0xFFA47FEE),
  500: Color(purplerInfoColor),
  600: Color(0xFF643DB7),
  700: Color(0xFF5836AC),
  800: Color(0xFF4C2FA1),
  900: Color(0xFF381F8D),
});
