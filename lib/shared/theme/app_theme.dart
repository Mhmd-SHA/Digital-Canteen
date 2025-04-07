import 'package:digital_canteen/shared/constants/app_keys.dart';
import 'package:digital_canteen/shared/data/local/storage_service.dart';
import 'package:digital_canteen/shared/providers/shared_preferences_storage_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
  (ref) {
    final storage = ref.watch(storageServiceProvider);
    return AppThemeModeNotifier(storage);
  },
);

class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
  final StorageService storageService;

  ThemeMode currentTheme = ThemeMode.light;

  AppThemeModeNotifier(this.storageService) : super(ThemeMode.light) {
    getCurrentTheme();
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    storageService.set(APP_THEME_STORAGE_KEY, state.name);
  }

  void getCurrentTheme() async {
    final theme = await storageService.get(APP_THEME_STORAGE_KEY);
    final value = ThemeMode.values.byName('${theme ?? 'light'}');
    state = value;
  }
}

class AppTheme {
  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: lightColorScheme.primary,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.surface,
      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          splashFactory: InkRipple.splashFactory,
          foregroundColor: lightColorScheme.onPrimaryFixed,
        ),
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: darkColorScheme.primary,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.surface,

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          splashFactory: InkRipple.splashFactory,
          foregroundColor: darkColorScheme.onPrimaryFixed,
        ),
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }

  /// Light [ColorScheme] made with FlexColorScheme v8.2.0.
  /// Requires Flutter 3.22.0 or later.
  static ColorScheme lightColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    // primary: Color(0xFF35693E),
    primary: Color(0xff76FF03),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFB7F1BA),
    onPrimaryContainer: Color(0xFF002109),
    primaryFixed: Color(0xFFB7F1BA),
    primaryFixedDim: Color(0xFF9CD4A0),
    onPrimaryFixed: Color(0xFF002109),
    onPrimaryFixedVariant: Color(0xFF1C5128),
    secondary: Color(0xFF4C626A),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCFE6F1),
    onSecondaryContainer: Color(0xFF071E26),
    secondaryFixed: Color(0xFFCFE6F1),
    secondaryFixedDim: Color(0xFFB3CAD4),
    onSecondaryFixed: Color(0xFF071E26),
    onSecondaryFixedVariant: Color(0xFF344A52),
    tertiary: Color(0xFF3C6472),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC0E9FA),
    onTertiaryContainer: Color(0xFF001F28),
    tertiaryFixed: Color(0xFFC0E9FA),
    tertiaryFixedDim: Color(0xFFA4CDDD),
    onTertiaryFixed: Color(0xFF001F28),
    onTertiaryFixedVariant: Color(0xFF234C5A),
    error: Color(0xFFB91A24),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD7),
    onErrorContainer: Color(0xFF410004),
    surface: Color(0xFFF5FAF1),
    onSurface: Color(0xFF181D18),
    surfaceDim: Color(0xFFD6DAD2),
    surfaceBright: Color(0xFFF5FAF1),
    surfaceContainerLowest: Color(0xFFFDFEFD),
    surfaceContainerLow: Color(0xFFF0F4EB),
    surfaceContainer: Color(0xFFEAEEE6),
    surfaceContainerHigh: Color(0xFFE4E8E0),
    surfaceContainerHighest: Color(0xFFDFE3DA),
    onSurfaceVariant: Color(0xFF414941),
    outline: Color(0xFF727970),
    outlineVariant: Color(0xFFC1C9BE),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF2D322C),
    onInverseSurface: Color(0xFFEEF2EA),
    inversePrimary: Color(0xFF9CD4A0),
    surfaceTint: Color(0xFF35693E),
  );

  /// Dark [ColorScheme] made with FlexColorScheme v8.2.0.
  /// Requires Flutter 3.22.0 or later.
  static ColorScheme darkColorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    // primary: Color(0xFF9CD4A0),
    primary: Color(0xff76FF03),
    onPrimary: Color(0xFF003914),
    primaryContainer: Color(0xFF1C5128),
    onPrimaryContainer: Color(0xFFB7F1BA),
    primaryFixed: Color(0xFFB7F1BA),
    primaryFixedDim: Color(0xFF9CD4A0),
    onPrimaryFixed: Color(0xFF002109),
    onPrimaryFixedVariant: Color(0xFF1C5128),
    secondary: Color(0xFFB3CAD4),
    onSecondary: Color(0xFF1E333B),
    secondaryContainer: Color(0xFF344A52),
    onSecondaryContainer: Color(0xFFCFE6F1),
    secondaryFixed: Color(0xFFCFE6F1),
    secondaryFixedDim: Color(0xFFB3CAD4),
    onSecondaryFixed: Color(0xFF071E26),
    onSecondaryFixedVariant: Color(0xFF344A52),
    tertiary: Color(0xFFA4CDDD),
    onTertiary: Color(0xFF053542),
    tertiaryContainer: Color(0xFF234C5A),
    onTertiaryContainer: Color(0xFFC0E9FA),
    tertiaryFixed: Color(0xFFC0E9FA),
    tertiaryFixedDim: Color(0xFFA4CDDD),
    onTertiaryFixed: Color(0xFF001F28),
    onTertiaryFixedVariant: Color(0xFF234C5A),
    error: Color(0xFFFFB2BC),
    onError: Color(0xFF600F26),
    errorContainer: Color(0xFF7E273B),
    onErrorContainer: Color(0xFFFFD9DD),
    surface: Color(0xFF131913),
    onSurface: Color(0xFFE0E4DB),
    surfaceDim: Color(0xFF131913),
    surfaceBright: Color(0xFF383D37),
    surfaceContainerLowest: Color(0xFF0E130E),
    surfaceContainerLow: Color(0xFF1B211B),
    surfaceContainer: Color(0xFF1F251F),
    surfaceContainerHigh: Color(0xFF282E28),
    surfaceContainerHighest: Color(0xFF333932),
    onSurfaceVariant: Color(0xFFC1C9BE),
    outline: Color(0xFF8B9389),
    outlineVariant: Color(0xFF414941),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFDFE4DA),
    onInverseSurface: Color(0xFF2D322C),
    inversePrimary: Color(0xFF35693E),
    surfaceTint: Color(0xFF9CD4A0),
  );
}
