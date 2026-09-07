import 'package:flutter/material.dart';

class BarColorResolver {
  const BarColorResolver();

  /// Resuelve el color efectivo del Status Bar para el cálculo de luminosidad.
  Color resolveStatusBarColor({
    required bool isImmersive,
    required bool showStatusBar,
    required Color statusBarColor,
    required Color scaffoldBackgroundColor,
    Color? topColor,
  }) {
    // 🛡️ PRIORIDAD 1: Si se proporciona un color explícito de fondo, úsalo siempre.
    // Esto es crucial cuando showStatusBar es false pero la barra del sistema sigue siendo
    // transparente y deja ver el color real de tu widget (ej. tu Container azul oscuro).
    if (topColor != null) {
      return topColor;
    }

    // 🛡️ PRIORIDAD 2: Lógica por defecto si no hay color explícito
    if (isImmersive || !showStatusBar) {
      return scaffoldBackgroundColor;
    } else if (!isImmersive || showStatusBar) {
      return scaffoldBackgroundColor;
    }

    return statusBarColor;
  }

  /// Resuelve el color efectivo del Navigation Bar para el cálculo de luminosidad.
  Color resolveNavigationBarColor({
    required bool isImmersive,
    required bool showNavigationBar,
    required bool shouldPaint,
    required Color navigationBarColor,
    required Color scaffoldBackgroundColor,
    Color? bottomColor,
  }) {
    // 🛡️ PRIORIDAD 1: Color explícito de fondo tiene máxima prioridad
    if (bottomColor != null) {
      return bottomColor;
    }

    // 🛡️ PRIORIDAD 2: Lógica por defecto
    if (isImmersive || !showNavigationBar || !shouldPaint) {
      return scaffoldBackgroundColor;
    } else if (!isImmersive || showNavigationBar || shouldPaint) {
      return scaffoldBackgroundColor;
    }

    return navigationBarColor;
  }

  /// Determina si los iconos deben ser oscuros según la luminancia del color efectivo.
  bool shouldUseDarkIcons({
    required bool? userPreference,
    required Color effectiveColor,
  }) {
    // Si el usuario fuerza una preferencia, se respeta ciegamente
    if (userPreference != null) return userPreference;

    // Luminancia > 0.5 = fondo claro -> iconos oscuros
    // Luminancia <= 0.5 = fondo oscuro -> iconos claros (blancos)
    return effectiveColor.computeLuminance() > 0.6;
  }
}
