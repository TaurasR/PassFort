import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  const PageBackground(
      {super.key,
      this.child,
      this.colors = const [
        Color.fromARGB(255, 35, 128, 77),
        Color.fromARGB(255, 13, 104, 59),
      ]});

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
