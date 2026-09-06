import 'package:flutter/material.dart';

class FakeStatusBar extends StatelessWidget {
  final double height;
  final Color color;

  const FakeStatusBar({super.key, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    // Sin Positioned: solo contenido. El caller (ScaffoldWidgetBuilder) lo posiciona.
    return IgnorePointer(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Container(color: color),
      ),
    );
  }
}
