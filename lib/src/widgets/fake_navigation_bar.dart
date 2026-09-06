import 'package:flutter/material.dart';

enum NavBarPosition { bottom, left, right }

class FakeNavigationBar extends StatelessWidget {
  final double size;
  final Color color;
  final NavBarPosition position;

  const FakeNavigationBar({
    super.key,
    required this.size,
    required this.color,
    this.position = NavBarPosition.bottom,
  });

  @override
  Widget build(BuildContext context) {
    // SizedBox asegura el tamaño correcto según la orientación
    return IgnorePointer(
      child: SizedBox(
        width: position == NavBarPosition.bottom ? double.infinity : size,
        height: position == NavBarPosition.bottom ? size : double.infinity,
        child: Container(color: color),
      ),
    );
  }
}
