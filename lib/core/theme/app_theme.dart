import 'package:flutter/material.dart';
import '../../res/app_text_styles.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    fontFamily: AppTextStyles.fontFamily,

    scaffoldBackgroundColor:
    AppColors.lightBackground,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,

      primaryContainer:
      AppColors.primaryContainer,
      onPrimaryContainer:
      AppColors.onPrimaryContainer,

      primaryFixed:
      AppColors.primaryFixed,
      primaryFixedDim:
      AppColors.primaryFixedDim,
      onPrimaryFixed:
      AppColors.onPrimaryFixed,
      onPrimaryFixedVariant:
      AppColors.onPrimaryFixedVariant,

      secondary:
      AppColors.secondary,
      onSecondary:
      AppColors.onSecondary,

      secondaryContainer:
      AppColors.secondaryContainer,
      onSecondaryContainer:
      AppColors.onSecondaryContainer,

      secondaryFixed:
      AppColors.secondaryFixed,
      secondaryFixedDim:
      AppColors.secondaryFixedDim,
      onSecondaryFixed:
      AppColors.onSecondaryFixed,
      onSecondaryFixedVariant:
      AppColors.onSecondaryFixedVariant,

      tertiary:
      AppColors.tertiary,
      onTertiary:
      AppColors.onTertiary,

      tertiaryContainer:
      AppColors.tertiaryContainer,
      onTertiaryContainer:
      AppColors.onTertiaryContainer,

      tertiaryFixed:
      AppColors.tertiaryFixed,
      tertiaryFixedDim:
      AppColors.tertiaryFixedDim,
      onTertiaryFixed:
      AppColors.onTertiaryFixed,
      onTertiaryFixedVariant:
      AppColors.onTertiaryFixedVariant,

      surface:
      AppColors.lightSurface,
      onSurface:
      AppColors.lightTextPrimary,

      surfaceContainerLowest:
      AppColors.lightSurfaceContainerLowest,

      surfaceContainerLow:
      AppColors.lightSurfaceContainerLow,

      surfaceContainer:
      AppColors.lightSurfaceContainer,

      surfaceContainerHigh:
      AppColors.lightSurfaceContainerHigh,

      surfaceContainerHighest:
      AppColors.lightSurfaceContainerHighest,

      surfaceDim:
      AppColors.lightSurfaceDim,

      surfaceBright:
      AppColors.lightSurfaceBright,

      outline:
      AppColors.lightOutline,

      outlineVariant:
      AppColors.lightOutlineVariant,

      error:
      AppColors.error,
      onError:
      AppColors.onError,

      errorContainer:
      AppColors.errorContainer,
      onErrorContainer:
      AppColors.onErrorContainer,
    ),

    // ============================================================
    // APP BAR
    // ============================================================

    appBarTheme: const AppBarTheme(
      backgroundColor:
      AppColors.lightBackground,
      foregroundColor:
      AppColors.lightTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),

    // ============================================================
    // TEXT THEME
    // ============================================================

    textTheme: TextTheme(
      displayLarge:
      AppTextStyles.displayLarge.copyWith(
        color: AppColors.lightTextPrimary,
      ),

      headlineMedium:
      AppTextStyles.headlineMedium.copyWith(
        color: AppColors.lightTextPrimary,
      ),

      headlineSmall:
      AppTextStyles.headlineSmall.copyWith(
        color: AppColors.lightTextPrimary,
      ),

      bodyLarge:
      AppTextStyles.bodyLarge.copyWith(
        color: AppColors.lightTextPrimary,
      ),

      bodyMedium:
      AppTextStyles.bodyMedium.copyWith(
        color: AppColors.lightTextPrimary,
      ),

      labelMedium:
      AppTextStyles.labelMedium.copyWith(
        color: AppColors.lightTextPrimary,
      ),

      labelSmall:
      AppTextStyles.labelSmall.copyWith(
        color: AppColors.lightTextPrimary,
      ),
    ),

    // ============================================================
    // CARD
    // ============================================================

    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(
          color: AppColors.lightBorder,
          width: 1,
        ),
      ),
    ),

    // ============================================================
    // INPUT
    // ============================================================

    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor:
      AppColors.lightSurface,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color: AppColors.lightBorder,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color: AppColors.lightBorder,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color: AppColors.error,
        ),
      ),

      focusedErrorBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),

      hintStyle:
      AppTextStyles.bodyMedium.copyWith(
        color: AppColors.lightTextHint,
      ),

      labelStyle:
      AppTextStyles.bodyMedium.copyWith(
        color: AppColors.lightTextSecondary,
      ),
    ),

    // ============================================================
    // ELEVATED BUTTON
    // ============================================================

    elevatedButtonTheme:
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        AppColors.primary,

        foregroundColor:
        AppColors.onPrimary,

        minimumSize:
        const Size.fromHeight(52),

        elevation: 0,

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),

        textStyle:
        AppTextStyles.labelMedium.copyWith(
          color:
          AppColors.onPrimary,
          fontWeight:
          FontWeight.w600,
        ),
      ),
    ),

    // ============================================================
    // OUTLINED BUTTON
    // ============================================================

    outlinedButtonTheme:
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor:
        AppColors.primary,

        minimumSize:
        const Size.fromHeight(52),

        side:
        const BorderSide(
          color: AppColors.primary,
        ),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),

        textStyle:
        AppTextStyles.labelMedium.copyWith(
          fontWeight:
          FontWeight.w600,
        ),
      ),
    ),

    // ============================================================
    // TEXT BUTTON
    // ============================================================

    textButtonTheme:
    TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor:
        AppColors.primary,

        textStyle:
        AppTextStyles.labelMedium.copyWith(
          fontWeight:
          FontWeight.w600,
        ),
      ),
    ),

    // ============================================================
    // DIVIDER
    // ============================================================

    dividerTheme:
    const DividerThemeData(
      color:
      AppColors.lightDivider,
      thickness: 1,
      space: 1,
    ),

    // ============================================================
    // BOTTOM NAVIGATION
    // ============================================================

    bottomNavigationBarTheme:
    const BottomNavigationBarThemeData(
      backgroundColor:
      AppColors.lightSurface,

      selectedItemColor:
      AppColors.primary,

      unselectedItemColor:
      AppColors.lightTextHint,

      elevation: 0,

      type:
      BottomNavigationBarType.fixed,
    ),

    // ============================================================
    // NAVIGATION BAR
    // ============================================================

    navigationBarTheme:
    NavigationBarThemeData(
      backgroundColor:
      AppColors.lightSurface,

      elevation: 0,

      indicatorColor:
      AppColors.primary.withValues(
        alpha: 0.10,
      ),

      labelTextStyle:
      WidgetStateProperty.all(
        AppTextStyles.labelSmall.copyWith(
          color:
          AppColors.lightTextPrimary,
        ),
      ),
    ),
  );

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily:
    AppTextStyles.fontFamily,

    scaffoldBackgroundColor:
    AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary:
      AppColors.primary,
      onPrimary:
      AppColors.onPrimary,

      primaryContainer:
      AppColors.primaryContainer,
      onPrimaryContainer:
      AppColors.onPrimaryContainer,

      primaryFixed:
      AppColors.primaryFixed,
      primaryFixedDim:
      AppColors.primaryFixedDim,
      onPrimaryFixed:
      AppColors.onPrimaryFixed,
      onPrimaryFixedVariant:
      AppColors.onPrimaryFixedVariant,

      secondary:
      AppColors.gold,
      onSecondary:
      AppColors.onSecondary,

      secondaryContainer:
      AppColors.secondaryContainer,
      onSecondaryContainer:
      AppColors.onSecondaryContainer,

      tertiary:
      AppColors.tertiary,
      onTertiary:
      AppColors.onTertiary,

      tertiaryContainer:
      AppColors.tertiaryContainer,
      onTertiaryContainer:
      AppColors.onTertiaryContainer,

      surface:
      AppColors.darkSurface,
      onSurface:
      AppColors.darkTextPrimary,

      surfaceContainerLowest:
      AppColors.darkSurface,

      surfaceContainerLow:
      AppColors.darkSurfaceVariant,

      surfaceContainer:
      AppColors.darkSurfaceVariant,

      surfaceContainerHigh:
      AppColors.darkSurfaceVariant,

      surfaceContainerHighest:
      AppColors.darkSurfaceVariant,

      outline:
      AppColors.darkBorder,

      outlineVariant:
      AppColors.darkBorder,

      error:
      AppColors.error,
      onError:
      AppColors.onError,

      errorContainer:
      AppColors.errorContainer,
      onErrorContainer:
      AppColors.onErrorContainer,
    ),

    appBarTheme:
    const AppBarTheme(
      backgroundColor:
      AppColors.darkBackground,
      foregroundColor:
      AppColors.darkTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),

    textTheme: TextTheme(
      displayLarge:
      AppTextStyles.displayLarge.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),

      headlineMedium:
      AppTextStyles.headlineMedium.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),

      headlineSmall:
      AppTextStyles.headlineSmall.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),

      bodyLarge:
      AppTextStyles.bodyLarge.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),

      bodyMedium:
      AppTextStyles.bodyMedium.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),

      labelMedium:
      AppTextStyles.labelMedium.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),

      labelSmall:
      AppTextStyles.labelSmall.copyWith(
        color:
        AppColors.darkTextPrimary,
      ),
    ),

    cardTheme:
    CardThemeData(
      color:
      AppColors.darkSurface,

      elevation: 0,

      margin: EdgeInsets.zero,

      shape:
      RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(24),
        side:
        const BorderSide(
          color:
          AppColors.darkBorder,
          width: 1,
        ),
      ),
    ),

    inputDecorationTheme:
    InputDecorationTheme(
      filled: true,

      fillColor:
      AppColors.darkSurface,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color:
          AppColors.darkBorder,
        ),
      ),

      enabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color:
          AppColors.darkBorder,
        ),
      ),

      focusedBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
        borderSide:
        const BorderSide(
          color:
          AppColors.gold,
          width: 1.5,
        ),
      ),

      hintStyle:
      AppTextStyles.bodyMedium.copyWith(
        color:
        AppColors.darkTextHint,
      ),

      labelStyle:
      AppTextStyles.bodyMedium.copyWith(
        color:
        AppColors.darkTextSecondary,
      ),
    ),

    elevatedButtonTheme:
    ElevatedButtonThemeData(
      style:
      ElevatedButton.styleFrom(
        backgroundColor:
        AppColors.primary,

        foregroundColor:
        AppColors.onPrimary,

        minimumSize:
        const Size.fromHeight(52),

        elevation: 0,

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),

        textStyle:
        AppTextStyles.labelMedium.copyWith(
          color:
          AppColors.onPrimary,
          fontWeight:
          FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme:
    OutlinedButtonThemeData(
      style:
      OutlinedButton.styleFrom(
        foregroundColor:
        AppColors.darkTextPrimary,

        minimumSize:
        const Size.fromHeight(52),

        side:
        const BorderSide(
          color:
          AppColors.darkBorder,
        ),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),
      ),
    ),

    textButtonTheme:
    TextButtonThemeData(
      style:
      TextButton.styleFrom(
        foregroundColor:
        AppColors.gold,

        textStyle:
        AppTextStyles.labelMedium.copyWith(
          fontWeight:
          FontWeight.w600,
        ),
      ),
    ),

    dividerTheme:
      DividerThemeData(
      color:
      AppColors.darkDivider,
      thickness: 1,
      space: 1,
    ),

    bottomNavigationBarTheme:
    const BottomNavigationBarThemeData(
      backgroundColor:
      AppColors.darkSurface,

      selectedItemColor:
      AppColors.gold,

      unselectedItemColor:
      AppColors.darkTextHint,

      elevation: 0,

      type:
      BottomNavigationBarType.fixed,
    ),

    navigationBarTheme:
    NavigationBarThemeData(
      backgroundColor:
      AppColors.darkSurface,

      elevation: 0,

      indicatorColor:
      AppColors.gold.withValues(
        alpha: 0.12,
      ),

      labelTextStyle:
      WidgetStateProperty.all(
        AppTextStyles.labelSmall.copyWith(
          color:
          AppColors.darkTextPrimary,
        ),
      ),
    ),
  );
}