import 'package:flutter/material.dart';

class TripperColors {
  const TripperColors._({
    required this.textPrimary,
    required this.textSecondary,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.borderPrimary,
    required this.borderSecondary,
    required this.borderTertiary,
    required this.buttonPrimaryBackground,
    required this.buttonPrimaryText,
    required this.buttonPrimaryBackgroundDisabled,
    required this.buttonSecondaryBackground,
    required this.buttonSecondaryText,
    required this.buttonSecondaryFrame,
    required this.buttonAccentBackground,
    required this.buttonAccentText,
    required this.shadowDividerColors,
    required this.blackWhitePrimary,
    required this.blackWhiteSecondary,
  });

  static TripperColors of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return dark;
      case Brightness.light:
        return light;
    }
  }

  final Color textPrimary;
  final Color textSecondary;
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color borderPrimary;
  final Color borderSecondary;
  final Color borderTertiary;
  final Color buttonPrimaryBackground;
  final Color buttonPrimaryText;
  final Color buttonPrimaryBackgroundDisabled;
  final Color buttonSecondaryBackground;
  final Color buttonSecondaryText;
  final Color buttonSecondaryFrame;
  final Color buttonAccentBackground;
  final Color buttonAccentText;
  final Color blackWhitePrimary;
  final Color blackWhiteSecondary;
  final List<Color> shadowDividerColors;

  static const light = TripperColors._(
    textPrimary: brandPrimary,
    textSecondary: Color(0xFF6A6A62),
    backgroundPrimary: brandSecondary,
    backgroundSecondary: Color(0xFFEEEEEC),
    iconPrimary: brandPrimary,
    iconSecondary: Color(0xFF878787),
    borderPrimary: Color(0xFFEEEEEC),
    borderSecondary: Color(0xFF878787),
    borderTertiary: brandPrimary,
    buttonPrimaryBackground: brandPrimary,
    buttonPrimaryText: _white,
    buttonPrimaryBackgroundDisabled: Color(0xFF6A6A62),
    buttonSecondaryBackground: brandSecondary,
    buttonSecondaryText: brandPrimary,
    buttonSecondaryFrame: Color(0xFFEEEEEC),
    buttonAccentBackground: brandAccent,
    buttonAccentText: brandPrimary,
    blackWhitePrimary: _black,
    blackWhiteSecondary: _white,
    shadowDividerColors: [Color(0x1A0F0F0F), Color(0x000F0F0F)],
  );

  static const dark = TripperColors._(
    textPrimary: Color(0xFFEDEDED),
    textSecondary: Color(0xFF9F9F9F),
    backgroundPrimary: Color(0xFF1A1A1A),
    backgroundSecondary: Color(0xFF363636),
    iconPrimary: Color(0xFFEDEDED),
    iconSecondary: Color(0xFF616161),
    borderPrimary: Color(0xFF363636),
    borderSecondary: Color(0xFF616161),
    borderTertiary: Color(0xFFEDEDED),
    buttonPrimaryBackground: Color(0xFFEDEDED),
    buttonPrimaryText: Color(0xFF1A1A1A),
    buttonPrimaryBackgroundDisabled: brandSecondary,
    buttonSecondaryBackground: Color(0xFF1A1A1A),
    buttonSecondaryText: Color(0xFFEDEDED),
    buttonSecondaryFrame: Color(0xFF363636),
    buttonAccentBackground: brandAccent,
    buttonAccentText: Color(0xFF1A1A1A),
    blackWhitePrimary: _white,
    blackWhiteSecondary: _black,
    shadowDividerColors: [Color(0xBF000000), Color(0x000F0F0F)],
  );

  // How to set opacity in Hex https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4

  /// charcoal #252525
  static const Color brandPrimary = Color(0xFF252525);

  ///darkLinen #F8F8F7
  static const Color brandSecondary = Color(0xFFF8F8F7);

  /// limeGreen #C7F860
  static const Color brandAccent = Color(0xFFC7F860);

  /// charcoal 40% #252525
  static const Color overlay = Color(0x66252525);

  /// black 20% #000000
  static const Color shadow20 = Color(0x33000000);

  /// charcoal 16% #252525
  static const Color shadow16 = Color(0x29252525);

  /// charcoal 8% #252525
  static const Color shadow08 = Color(0x14252525);

  /// black 4% #000000
  static const Color shadow04 = Color(0x0A000000);

  /// _white 0% #000000
  static const Color transparent = Color(0x00000000);

  static const Color stateTextPrimary = _black;
  static const Color stateTextSecondary = _white;

  /// #F15147
  static const Color stateBackgroundError = Color(0xFFF15147);

  /// #FFF495
  static const Color stateBackgroundWarning = Color(0xFFFFF495);

  /// #439E5C
  static const Color stateBackgroundSuccess = Color(0xFF439E5C);

  /// #252525
  static const Color categoriesTextPrimary = brandPrimary;

  /// #6A6A62
  static const Color categoriesTextSecondary = Color(0xFF6A6A62);

  /// #FFFFFF
  static const Color categoriesBackgroundShowMeEverything = _white;

  /// #439E5C
  static const Color snackBarSuccess = stateBackgroundSuccess;

  /// #FFF495
  static const Color snackBarWarning = stateBackgroundWarning;

  /// #F15147
  static const Color snackBarError = stateBackgroundError;

  /// #FFFFFF
  static const Color snackBarInfo = _white;

  static const String shareBackgroundTopColor = "#FFFFFF";
  static const String shareBackgroundBottomColor = "#FFFFFF";

  /// #EEEEEC
  static const deepDivePillBackground = Color(0xFFEEEEEC);

  /// #000000
  static const Color _black = Color(0xFF000000);

  /// #FFFFFF
  static const Color _white = Color(0xFFFFFFFF);

  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = {
      50: _getShade(color, value: 0.5),
      100: _getShade(color, value: 0.4),
      200: _getShade(color, value: 0.3),
      300: _getShade(color, value: 0.2),
      400: _getShade(color, value: 0.1),
      500: color,
      600: _getShade(color, value: 0.1, darker: true),
      700: _getShade(color, value: 0.15, darker: true),
      800: _getShade(color, value: 0.2, darker: true),
      900: _getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

  static Color _getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((darker ? (hsl.lightness - value) : (hsl.lightness + value)).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
