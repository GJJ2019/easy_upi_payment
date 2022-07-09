import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppTheme {
  /// for getting light theme
  ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.green,
    );
  }

  /// for getting dark theme
  ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.green,
    );
  }
}

/// for providing app theme [AppTheme]
final appThemeProvider = Provider<AppTheme>((_) => AppTheme());
