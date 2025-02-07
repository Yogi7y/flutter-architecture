import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'light_theme.dart';

@immutable
abstract class AppTheme {
  const AppTheme({
    required this.surface0,
    required this.textPrimary,
    required this.textSecondary,
    required this.neutral200,
    required this.statusColor,
  });

  final Color surface0;
  final Color textPrimary;
  final Color textSecondary;

  final Color neutral200;

  final Color statusColor;
}

final themeProvider = StateProvider<AppTheme>((ref) => LightTheme());
