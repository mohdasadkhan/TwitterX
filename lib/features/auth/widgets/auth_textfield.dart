import 'package:flutter/material.dart';
import 'package:twitterx/theme/theme.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const AuthField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Pallete.blueColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: hint,
        ));
  }
}
