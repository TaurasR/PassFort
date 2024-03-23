import 'package:flutter/material.dart';

class ButtonWide extends StatelessWidget {
  const ButtonWide(
      {super.key,
      required this.text,
      this.textSize = 20,
      this.buttonWidth = 300,
      this.buttonHeight = 45,
      this.buttonBorderRadius = 10,
      required this.onPressed,
      this.icon});

  final String text;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final double buttonBorderRadius;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
              side: const BorderSide(color: Colors.black, width: 1.2),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(fontSize: textSize)),
            if (icon != null) const Text(' '),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }
}
