import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripper/screens/utils/colors.dart';
import 'package:tripper/screens/utils/dimensions.dart';
import 'package:tripper/screens/utils/styles.dart';
import 'package:tripper/utils/platform.dart';

class TripperTheme {
  static ThemeData get light => _data(Brightness.light, TripperColors.light, ThemeData.light());

  static ThemeData get dark => _data(Brightness.dark, TripperColors.dark, ThemeData.dark());

  static SystemUiOverlayStyle systemUIOverlayStyleDark = SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: TripperColors.dark.backgroundPrimary,
    systemNavigationBarDividerColor: TripperColors.dark.backgroundPrimary,
  );

  static SystemUiOverlayStyle systemUIOverlayStyleLight = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: TripperColors.light.backgroundPrimary,
    systemNavigationBarDividerColor: TripperColors.light.backgroundPrimary,
  );

  static ThemeData _data(
    Brightness brightness,
    TripperColors colors,
    ThemeData baseData,
  ) =>
      ThemeData(
        useMaterial3: true,
        brightness: brightness,
        splashFactory: NoSplash.splashFactory,
        primarySwatch: TripperColors.getMaterialColorFromColor(colors.textPrimary),
        colorScheme: baseData.colorScheme.copyWith(background: colors.backgroundPrimary),
        scaffoldBackgroundColor: colors.backgroundPrimary,
        highlightColor: kIsApple ? TripperColors.transparent : null,
        appBarTheme: AppBarTheme(
          elevation: 0,
          shadowColor: TripperColors.overlay,
          foregroundColor: colors.textPrimary,
          backgroundColor: colors.backgroundPrimary,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colors.backgroundPrimary,
          modalBackgroundColor: colors.backgroundPrimary,
        ),
        iconTheme: IconThemeData(color: colors.iconPrimary),
        tabBarTheme: baseData.tabBarTheme.copyWith(
          labelColor: colors.textPrimary,
          unselectedLabelColor: colors.textSecondary,
        ),
        dividerColor: colors.borderPrimary,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: colors.backgroundPrimary,
          selectedLabelStyle: TripperStyles.tabBarLabelStyle,
          unselectedLabelStyle: TripperStyles.tabBarLabelStyle,
          selectedItemColor: colors.textPrimary,
          unselectedItemColor: colors.iconSecondary,
        ),
        textTheme: baseData.textTheme.apply(
          bodyColor: colors.textPrimary,
          displayColor: colors.textPrimary,
          decorationColor: colors.textPrimary,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colors.textPrimary,
          selectionColor: TripperColors.brandAccent,
          selectionHandleColor: colors.textPrimary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: colors.textSecondary,
          hintStyle: TextStyle(
            color: colors.textPrimary,
          ),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: baseData.buttonTheme.colorScheme?.onPrimaryContainer,
          inactiveTrackColor: baseData.buttonTheme.colorScheme?.secondaryContainer,
          thumbColor: baseData.buttonTheme.colorScheme?.onPrimaryContainer,
          overlayColor: baseData.buttonTheme.colorScheme?.secondaryContainer,
          tickMarkShape: SliderTickMarkShape.noTickMark,
          trackHeight: 2,
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: Dimensions.s,
          ),
          overlayShape: const RoundSliderOverlayShape(
            overlayRadius: Dimensions.m,
          ),
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: colors.textPrimary,
          primaryContrastingColor: colors.textPrimary,
          barBackgroundColor: colors.backgroundPrimary,
          scaffoldBackgroundColor: colors.backgroundPrimary,
          textTheme: CupertinoTextThemeData(
            primaryColor: colors.textPrimary,
          ),
        ),
        badgeTheme: baseData.badgeTheme.copyWith(
          backgroundColor: TripperColors.stateBackgroundError,
          alignment: const AlignmentDirectional(Dimensions.l + Dimensions.xs, Dimensions.zero),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: Dimensions.one),
          largeSize: Dimensions.ml,
        ),
      );
}
