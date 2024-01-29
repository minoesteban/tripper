import 'package:flutter/material.dart';

class TripperStyles {
  static const tabBarLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const labelSmall = TextStyle(
    fontWeight: FontWeight.w500,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 1,
  );

  static const labelXSmall = TextStyle(
    fontWeight: FontWeight.w400,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 1,
  );

  static InputDecoration inputDecoration(BuildContext context, String hintText, IconData icon) {
    return InputDecoration(
      alignLabelWithHint: true,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      contentPadding: const EdgeInsets.all(8),
      hintText: hintText,
      isDense: false,
      hintStyle: labelSmall.copyWith(
        color: Theme.of(context).inputDecorationTheme.hintStyle?.color?.withOpacity(.5),
      ),
      suffixIcon: Icon(icon, color: Theme.of(context).iconTheme.color),
      border: InputBorder.none,
    );
  }
}
