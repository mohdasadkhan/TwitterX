import 'package:flutter/material.dart';
import 'package:twitterx/theme/theme.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const RoundButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.backgroundColor = Pallete.whiteColor,
      this.textColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
