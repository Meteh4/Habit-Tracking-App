import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final onChanged;
  final isObscure;
  final IconButton sufIcon;
  final Icon prefIcon;
  final String tlabel;
  const MyTextFormField({
    super.key,
    required this.onChanged,
    required this.isObscure,
    required this.sufIcon,
    required this.prefIcon,
    required this.tlabel});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color(0xFF395886),
      onChanged: onChanged,
      cursorHeight: 18,
      obscureText: isObscure,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF395886),
          ),
          borderRadius: BorderRadius.circular(20.10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.10),
          borderSide: const BorderSide(
            color: Color(0xFF395886),
          ),
        ),
        suffixIcon: sufIcon,
        prefixIcon: prefIcon,
        filled: true,
        fillColor: Colors.white60,
        labelText: tlabel,
        labelStyle: const TextStyle(
          color: Color(0xFF395886),
        ),
      ),
    );
  }
}


