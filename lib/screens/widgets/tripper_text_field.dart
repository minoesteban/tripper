import 'package:flutter/material.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/utils/styles.dart';

class TripperTextField extends StatelessWidget {
  const TripperTextField({
    required this.hintText,
    required this.icon,
    super.key,
  });

  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        height: Dimensions.inputFieldHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: TextField(
            style: TripperStyles.labelSmall,
            textAlignVertical: TextAlignVertical.center,
            decoration: TripperStyles.inputDecoration(context, hintText, icon),
          ),
        ),
      ),
    );
  }
}
