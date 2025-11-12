import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FontHelper {
  static Future<void> loadFonts() async {
    try {
      // Load MyriadPro fonts
      await rootBundle.load('assets/fonts/myriad_pro/MYRIADPRO-REGULAR.ttf');
      await rootBundle.load('assets/fonts/myriad_pro/MYRIADPRO-LIGHT.ttf');
      await rootBundle.load('assets/fonts/myriad_pro/MYRIADPRO-SEMIBOLD.ttf');
      await rootBundle.load('assets/fonts/myriad_pro/MYRIADPRO-SEMIBOLDIT.ttf');
      await rootBundle.load('assets/fonts/myriad_pro/MYRIADPRO-BOLD.ttf');
      await rootBundle.load('assets/fonts/myriad_pro/MYRIADPRO-BOLDIT.ttf');
    } catch (e) {
      debugPrint('❌ Error loading MyriadPro fonts: $e');
    }
  }

  static TextStyle getMyriadProTextStyle({double? fontSize, FontWeight? fontWeight, Color? color, double? height}) {
    return TextStyle(
      fontFamily: 'MyriadPro',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      fontFamilyFallback: ['Roboto', 'Arial', 'sans-serif'],
    );
  }

  static bool isFontLoaded(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return textStyle?.fontFamily == 'MyriadPro';
  }
}
