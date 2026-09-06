import 'package:flutter/material.dart';

/// Widget que aísla a sus hijos del redimensionamiento por teclado.
///
/// Útil para overlays (como fake status/nav bars) que deben mantenerse
/// fijos en sus posiciones independientemente de si el teclado está abierto.
class KeyboardInsensitive extends StatelessWidget {
  final Widget child;

  /// Si es true, también ignora viewPadding del teclado.
  final bool ignoreViewPadding;

  const KeyboardInsensitive({
    super.key,
    required this.child,
    this.ignoreViewPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQuery.copyWith(
        // Elimina el inset del teclado
        viewInsets: EdgeInsets.zero,
        // Opcionalmente también el padding del teclado
        viewPadding: ignoreViewPadding
            ? mediaQuery.viewPadding.copyWith(bottom: 0)
            : mediaQuery.viewPadding,
      ),
      child: child,
    );
  }
}
