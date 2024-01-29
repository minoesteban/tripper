import 'package:flutter/material.dart';

class TripperButton extends StatelessWidget {
  const TripperButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(text),
    );
  }
}
