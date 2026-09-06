import 'package:flutter/material.dart';
import '../widgets/fake_navigation_bar.dart';
import '../widgets/fake_status_bar.dart';
import 'scaffold_layout_calculator.dart';

class ScaffoldWidgetBuilder {
  const ScaffoldWidgetBuilder();

  Widget buildBottomNavigationBar({
    required Widget? bottomNavigationBar,
    required double bottomInset,
    required bool isImmersive,
  }) {
    if (bottomNavigationBar == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: isImmersive ? 0 : bottomInset),
      child: bottomNavigationBar,
    );
  }

  /// Solo construye el body con padding de safe areas (SIN fake bars).
  Widget buildBody({
    required Widget body,
    required SafeAreaValues safeAreas,
    required ScaffoldInsets insets,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: safeAreas.top ? insets.top : 0,
        bottom: safeAreas.bottom ? insets.bottom : 0,
        left: safeAreas.left ? insets.left : 0,
        right: safeAreas.right ? insets.right : 0,
      ),
      child: body,
    );
  }

  /// Construye las fake bars como widgets independientes (para el Stack raíz).
  List<Widget> buildFakeBars({
    required ScaffoldInsets insets,
    required Color statusBarColor,
    required Color navigationBarColor,
    required bool paintNavBar,
    required NavBarPosition navBarPosition,
    required double navBarSize,
  }) {
    return [
      if (insets.isStatusBarVisible)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: FakeStatusBar(height: insets.top, color: statusBarColor),
        ),
      if (insets.isNavBarVisible && paintNavBar)
        _buildPositionedNavBar(
          size: navBarSize,
          color: navigationBarColor,
          position: navBarPosition,
        ),
    ];
  }

  Widget _buildPositionedNavBar({
    required double size,
    required Color color,
    required NavBarPosition position,
  }) {
    switch (position) {
      case NavBarPosition.bottom:
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: size,
          child: FakeNavigationBar(
            size: size,
            color: color,
            position: position,
          ),
        );
      case NavBarPosition.left:
        return Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: size,
          child: FakeNavigationBar(
            size: size,
            color: color,
            position: position,
          ),
        );
      case NavBarPosition.right:
        return Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: size,
          child: FakeNavigationBar(
            size: size,
            color: color,
            position: position,
          ),
        );
    }
  }
}
