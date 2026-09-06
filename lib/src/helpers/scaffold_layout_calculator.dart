import 'package:flutter/material.dart';
import '../widgets/fake_navigation_bar.dart';

class ScaffoldLayoutCalculator {
  const ScaffoldLayoutCalculator();

  /// Detecta la posición de la navbar según los insets
  NavBarPosition detectNavBarPosition(MediaQueryData mediaQuery) {
    final bottom = mediaQuery.viewPadding.bottom;
    final left = mediaQuery.viewPadding.left;
    final right = mediaQuery.viewPadding.right;

    if (bottom > 0) return NavBarPosition.bottom;
    if (right > left && right > 0) return NavBarPosition.left;
    if (left > right && left > 0) return NavBarPosition.right;

    return NavBarPosition.bottom;
  }

  /// Calcula todos los insets necesarios
  ScaffoldInsets calculateInsets({
    required MediaQueryData mediaQuery,
    required bool isImmersive,
    required bool showStatusBar,
    required bool showNavigationBar,
    required bool respectNotchInImmersive,
    required bool respectBottomInImmersive,
    required NavBarPosition navBarPosition,
  }) {
    final isStatusBarVisible = !isImmersive && showStatusBar;
    final isNavBarVisible = !isImmersive && showNavigationBar;

    final shouldRespectTop = isStatusBarVisible || respectNotchInImmersive;
    final shouldRespectBottom = isNavBarVisible || respectBottomInImmersive;
    final shouldRespectLeft = respectNotchInImmersive;
    final shouldRespectRight = respectNotchInImmersive;

    final topInset = shouldRespectTop ? mediaQuery.viewPadding.top : 0.0;

    final bottomInset =
        (shouldRespectBottom && navBarPosition == NavBarPosition.bottom)
        ? mediaQuery.viewPadding.bottom
        : 0.0;

    final leftInset =
        (shouldRespectLeft && navBarPosition != NavBarPosition.left)
        ? mediaQuery.viewPadding.left
        : (shouldRespectBottom && navBarPosition == NavBarPosition.left)
        ? mediaQuery.viewPadding.left
        : 0.0;

    final rightInset =
        (shouldRespectRight && navBarPosition != NavBarPosition.right)
        ? mediaQuery.viewPadding.right
        : (shouldRespectBottom && navBarPosition == NavBarPosition.right)
        ? mediaQuery.viewPadding.right
        : 0.0;

    return ScaffoldInsets(
      top: topInset,
      bottom: bottomInset,
      left: leftInset,
      right: rightInset,
      isStatusBarVisible: isStatusBarVisible,
      isNavBarVisible: isNavBarVisible,
    );
  }

  /// Calcula los safe areas efectivos
  SafeAreaValues calculateSafeAreas({
    required bool safeAreaTop,
    required bool safeAreaBottom,
    required bool safeAreaLeft,
    required bool safeAreaRight,
    required bool respectNotchInImmersive,
    required bool respectBottomInImmersive,
    required bool isStatusBarVisible,
    required bool isNavBarVisible,
  }) {
    return SafeAreaValues(
      top: safeAreaTop && (isStatusBarVisible || respectNotchInImmersive),
      bottom: safeAreaBottom && (isNavBarVisible || respectBottomInImmersive),
      left: safeAreaLeft && respectNotchInImmersive,
      right: safeAreaRight && respectNotchInImmersive,
    );
  }

  /// Obtiene el tamaño de la navbar según su posición
  double getNavBarSize({
    required MediaQueryData mediaQuery,
    required NavBarPosition position,
  }) {
    switch (position) {
      case NavBarPosition.bottom:
        return mediaQuery.viewPadding.bottom;
      case NavBarPosition.left:
        return mediaQuery.viewPadding.left;
      case NavBarPosition.right:
        return mediaQuery.viewPadding.right;
    }
  }
}

/// Representa los insets calculados
class ScaffoldInsets {
  final double top;
  final double bottom;
  final double left;
  final double right;
  final bool isStatusBarVisible;
  final bool isNavBarVisible;

  const ScaffoldInsets({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
    required this.isStatusBarVisible,
    required this.isNavBarVisible,
  });
}

/// Representa los safe areas efectivos
class SafeAreaValues {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const SafeAreaValues({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });
}
