import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../controller/fake_bars_controller.dart';
import '../helpers/bar_color_resolver.dart';
import '../helpers/keyboard_insensitive.dart';
import '../helpers/lifecycle_observer.dart';
import '../helpers/scaffold_layout_calculator.dart';
import '../helpers/scaffold_widget_builder.dart';
import '../helpers/system_style_builder.dart';
import '../services/system_ui_service.dart';

class ScaffoldCustom extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  final Color? statusBarColor;
  final Color? navigationBarColor;
  final Color? scaffoldBackgroundColor;

  // 🆕 Nuevos parámetros para informar el color real detrás de las barras
  final Color? topColor;
  final Color? bottomColor;

  final bool? statusBarDarkIcons;
  final bool? navigationBarDarkIcons;
  final bool? showStatusBar;
  final bool? showNavigationBar;
  final bool? immersiveMode;
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final bool? safeAreaLeft;
  final bool? safeAreaRight;
  final bool respectNotchInImmersive;
  final bool respectBottomInImmersive;
  final bool resizeToAvoidBottomInset;
  final bool hideFakeBarsOnKeyboard;

  const ScaffoldCustom({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.statusBarColor,
    this.navigationBarColor,
    this.scaffoldBackgroundColor,
    this.topColor,
    this.bottomColor,
    this.statusBarDarkIcons,
    this.navigationBarDarkIcons,
    this.showStatusBar,
    this.showNavigationBar,
    this.immersiveMode,
    this.safeAreaTop,
    this.safeAreaBottom,
    this.safeAreaLeft,
    this.safeAreaRight,
    this.respectNotchInImmersive = false,
    this.respectBottomInImmersive = false,
    this.resizeToAvoidBottomInset = false,
    this.hideFakeBarsOnKeyboard = false,
  });

  @override
  State<ScaffoldCustom> createState() => _ScaffoldCustomState();
}

class _ScaffoldCustomState extends State<ScaffoldCustom>
    with WidgetsBindingObserver, LifecycleObserverMixin {
  static const _resolver = BarColorResolver();
  static const _layoutCalculator = ScaffoldLayoutCalculator();
  static const _widgetBuilder = ScaffoldWidgetBuilder();

  late Future<bool> _hasNavigationButtons;
  // ignore: unused_field
  bool _paintNavBar = false;

  @override
  void initState() {
    super.initState();
    _hasNavigationButtons = SystemUiService.hasNavigationButtons();
    _hasNavigationButtons.then((value) {
      if (mounted) {
        _paintNavBar = value;
        _applySystemUI();
      }
    });
    BarsUIController.instance.addListener(_onControllerChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _applySystemUI());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshNavigationButtons();
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _refreshNavigationButtons();
  }

  void _refreshNavigationButtons() {
    _hasNavigationButtons = SystemUiService.hasNavigationButtons();
    _hasNavigationButtons.then((value) {
      if (!mounted) return;
      _paintNavBar = value;
      _applySystemUI();

      if (SchedulerBinding.instance.schedulerPhase ==
          SchedulerPhase.persistentCallbacks) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() {});
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    BarsUIController.instance.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    _applySystemUI();
    if (!mounted) return;

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    } else {
      setState(() {});
    }
  }

  Future<void> _applySystemUI() =>
      SystemUiService.applySystemUiMode(isImmersive: _isImmersive);

  Color get _statusBarColor =>
      widget.statusBarColor ?? BarsUIController.instance.statusBarColor.value;
  Color get _navigationBarColor =>
      widget.navigationBarColor ??
      BarsUIController.instance.navigationBarColor.value;
  Color get _scaffoldBackgroundColor =>
      widget.scaffoldBackgroundColor ??
      BarsUIController.instance.scaffoldBackgroundColor.value;
  bool get _showStatusBar =>
      widget.showStatusBar ?? BarsUIController.instance.showStatusBar.value;
  bool get _showNavigationBar =>
      widget.showNavigationBar ??
      BarsUIController.instance.showNavigationBar.value;
  bool get _isImmersive =>
      widget.immersiveMode ?? BarsUIController.instance.immersiveMode.value;
  bool get _safeAreaTop =>
      widget.safeAreaTop ?? BarsUIController.instance.safeAreaTop.value;
  bool get _safeAreaBottom =>
      widget.safeAreaBottom ?? BarsUIController.instance.safeAreaBottom.value;
  bool get _safeAreaLeft =>
      widget.safeAreaLeft ?? BarsUIController.instance.safeAreaLeft.value;
  bool get _safeAreaRight =>
      widget.safeAreaRight ?? BarsUIController.instance.safeAreaRight.value;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasNavigationButtons,
      builder: (context, snapshot) {
        final paintNavBar = snapshot.data ?? false;
        final mediaQuery = MediaQuery.of(context);
        final isKeyboardOpen = mediaQuery.viewInsets.bottom > 0;

        final navBarPosition = _layoutCalculator.detectNavBarPosition(
          mediaQuery,
        );

        final insets = _layoutCalculator.calculateInsets(
          mediaQuery: mediaQuery,
          isImmersive: _isImmersive,
          showStatusBar: _showStatusBar,
          showNavigationBar: _showNavigationBar,
          respectNotchInImmersive: widget.respectNotchInImmersive,
          respectBottomInImmersive: widget.respectBottomInImmersive,
          navBarPosition: navBarPosition,
        );

        final safeAreas = _layoutCalculator.calculateSafeAreas(
          safeAreaTop: _safeAreaTop,
          safeAreaBottom: widget.bottomNavigationBar != null
              ? false
              : _safeAreaBottom,
          safeAreaLeft: _safeAreaLeft,
          safeAreaRight: _safeAreaRight,
          respectNotchInImmersive: widget.respectNotchInImmersive,
          respectBottomInImmersive: widget.respectBottomInImmersive,
          isStatusBarVisible: insets.isStatusBarVisible,
          isNavBarVisible: insets.isNavBarVisible,
        );

        // 🆕 Pasamos topColor y bottomColor al resolver
        final effectiveStatusBarColor = _resolver.resolveStatusBarColor(
          isImmersive: _isImmersive,
          showStatusBar: _showStatusBar,
          statusBarColor: _statusBarColor,
          scaffoldBackgroundColor: _scaffoldBackgroundColor,
          //topColor: widget.topColor,
        );

        final effectiveNavBarColor = _resolver.resolveNavigationBarColor(
          isImmersive: _isImmersive,
          showNavigationBar: _showNavigationBar,
          shouldPaint: paintNavBar,
          navigationBarColor: _navigationBarColor,
          scaffoldBackgroundColor: _scaffoldBackgroundColor,
          //bottomColor: widget.bottomColor,
        );

        final darkStatusIcons = _resolver.shouldUseDarkIcons(
          userPreference: widget.statusBarDarkIcons,
          effectiveColor: effectiveStatusBarColor,
        );
        final darkNavIcons = _resolver.shouldUseDarkIcons(
          userPreference: widget.navigationBarDarkIcons,
          effectiveColor: effectiveNavBarColor,
        );

        final systemStyle = SystemStyleBuilder.build(
          darkStatusBarIcons: darkStatusIcons,
          darkNavigationBarIcons: darkNavIcons,
        );

        final navBarSize = _layoutCalculator.getNavBarSize(
          mediaQuery: mediaQuery,
          position: navBarPosition,
        );

        final shouldHideFakeBars =
            widget.hideFakeBarsOnKeyboard && isKeyboardOpen;

        return Stack(
          children: [
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemStyle,
              child: Scaffold(
                appBar: widget.appBar,
                floatingActionButton: widget.floatingActionButton,
                backgroundColor: _scaffoldBackgroundColor,
                extendBody: false,
                extendBodyBehindAppBar: false,
                resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                bottomNavigationBar: _widgetBuilder.buildBottomNavigationBar(
                  bottomNavigationBar: widget.bottomNavigationBar,
                  bottomInset: insets.bottom,
                  isImmersive: _isImmersive,
                ),
                body: _widgetBuilder.buildBody(
                  body: widget.body,
                  safeAreas: safeAreas,
                  insets: insets,
                ),
              ),
            ),
            if (!shouldHideFakeBars)
              KeyboardInsensitive(
                child: Stack(
                  fit: StackFit.expand,
                  children: _widgetBuilder.buildFakeBars(
                    insets: insets,
                    statusBarColor: _statusBarColor,
                    navigationBarColor: _navigationBarColor,
                    paintNavBar: paintNavBar,
                    navBarPosition: navBarPosition,
                    navBarSize: navBarSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
