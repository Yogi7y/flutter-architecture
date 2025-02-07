import 'dart:ui';

import 'theme.dart';

class LightTheme implements AppTheme {
  LightTheme()
      : surface0 = const Color(0xFFF1F5F9),
        textPrimary = const Color(0xFF334155),
        textSecondary = const Color(0xFF64748B),
        neutral200 = const Color(0xffE2E8F0),
        statusColor = const Color(0xff966F22);

  @override
  final Color surface0;

  @override
  final Color textPrimary;

  @override
  final Color textSecondary;

  @override
  final Color neutral200;

  @override
  final Color statusColor;
}
