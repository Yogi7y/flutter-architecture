import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../colors/theme.dart';
import 'mobile_fonts.dart';

abstract class Typography {
  Typography({
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.label1,
    required this.label2,
    required this.caption1,
    required this.caption2,
  });

  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle label1;
  final TextStyle label2;
  final TextStyle caption1;
  final TextStyle caption2;
}

final fontsProvider = Provider<Typography>((ref) {
  final theme = ref.watch(themeProvider);
  return MobileFonts(theme: theme);
});
