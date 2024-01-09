import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  MyFloatingActionButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF395886),
      onPressed: onPressed,
      child: const Icon(Icons.add,
      color: Color(0XFFF0F3FA),),
    );
  }
}

