import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';

import '../colors/theme.dart';
import 'typography.dart';

class MobileFonts implements Typography {
  MobileFonts({required this.theme});

  final AppTheme theme;

  @override
  TextStyle get caption1 => TextStyle(
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: -.02,
        color: theme.textSecondary,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get caption2 => TextStyle(
        fontSize: 10,
        height: 12 / 10,
        letterSpacing: -.02,
        color: theme.textSecondary,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get heading1 => TextStyle(
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: -.02,
        fontWeight: FontWeight.w700,
        color: theme.textPrimary,
      );

  @override
  TextStyle get heading2 => TextStyle(
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: -.02,
        fontWeight: FontWeight.w600,
        color: theme.textPrimary,
      );

  @override
  TextStyle get heading3 => TextStyle(
        fontSize: 20,
        height: 28 / 20,
        letterSpacing: -.02,
        fontWeight: FontWeight.w500,
        color: theme.textPrimary,
      );

  @override
  TextStyle get label1 => TextStyle(
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: -.02,
        fontWeight: FontWeight.w500,
        color: theme.textPrimary,
      );

  @override
  TextStyle get label2 => TextStyle(
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: -.02,
        fontWeight: FontWeight.w500,
        color: theme.textPrimary,
      );
}
