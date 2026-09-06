import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/system_ui_service.dart';

class BarsUIController extends ChangeNotifier {
  static final BarsUIController instance = BarsUIController._internal();
  BarsUIController._internal();

  // --- Colores ---
  final ValueNotifier<Color> statusBarColor = ValueNotifier(Colors.transparent);
  final ValueNotifier<Color> navigationBarColor = ValueNotifier(
    Colors.transparent,
  );
  final ValueNotifier<Color> scaffoldBackgroundColor = ValueNotifier(
    Colors.white,
  );

  // --- Brillo de iconos ---
  final ValueNotifier<Brightness> statusBarIconBrightness = ValueNotifier(
    Brightness.dark,
  );
  final ValueNotifier<Brightness> navigationBarIconBrightness = ValueNotifier(
    Brightness.dark,
  );

  // --- Visibilidad de barras ---
  final ValueNotifier<bool> showStatusBar = ValueNotifier(true);
  final ValueNotifier<bool> showNavigationBar = ValueNotifier(true);
  final ValueNotifier<bool> immersiveMode = ValueNotifier(false);
  final ValueNotifier<bool> isGestureNavigation = ValueNotifier(true);

  // ✅ NUEVO: Control de SafeArea
  final ValueNotifier<bool> safeAreaTop = ValueNotifier(true);
  final ValueNotifier<bool> safeAreaBottom = ValueNotifier(true);

  // ✅ NUEVO: Control de SafeArea lateral
  final ValueNotifier<bool> safeAreaLeft = ValueNotifier(true);
  final ValueNotifier<bool> safeAreaRight = ValueNotifier(true);

  SystemUiOverlayStyle get currentSystemStyle => SystemUiOverlayStyle(
    statusBarColor: statusBarColor.value,
    systemNavigationBarColor: navigationBarColor.value,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: statusBarIconBrightness.value,
    systemNavigationBarIconBrightness: navigationBarIconBrightness.value,
    statusBarBrightness: statusBarIconBrightness.value == Brightness.dark
        ? Brightness.light
        : Brightness.dark,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
  );

  Future<void> init({required String packageName}) async {
    SystemUiService.setChannelName('$packageName/navigation');
    await SystemUiService.initEdgeToEdge();
    notifyListeners();
  }

  // --- Setters de color ---
  void setStatusBarColor(Color color) {
    statusBarColor.value = color;
    notifyListeners();
  }

  void setNavigationBarColor(Color color) {
    navigationBarColor.value = color;
    notifyListeners();
  }

  void setScaffoldBackgroundColor(Color color) {
    scaffoldBackgroundColor.value = color;
    notifyListeners();
  }

  // --- Setters de brillo ---
  void setStatusDarkIcons(bool dark) {
    statusBarIconBrightness.value = dark ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  void setNavigationDarkIcons(bool dark) {
    navigationBarIconBrightness.value = dark
        ? Brightness.dark
        : Brightness.light;
    notifyListeners();
  }

  void setDarkIcons(bool dark) {
    setStatusDarkIcons(dark);
    setNavigationDarkIcons(dark);
  }

  // --- Toggles de visibilidad ---
  void toggleStatusBar() {
    showStatusBar.value = !showStatusBar.value;
    notifyListeners();
  }

  void toggleNavigationBar() {
    showNavigationBar.value = !showNavigationBar.value;
    notifyListeners();
  }

  void toggleImmersive() {
    immersiveMode.value = !immersiveMode.value;
    notifyListeners();
  }

  Future<void> setImmersiveMode(bool enable) async {
    immersiveMode.value = enable;
    notifyListeners();
  }

  void setIsGestureNavigation(bool isGesture) {
    if (isGestureNavigation.value != isGesture) {
      isGestureNavigation.value = isGesture;
      notifyListeners();
    }
  }

  // ✅ NUEVO: Métodos para SafeArea

  /// Establece el SafeArea superior directamente.
  void setSafeAreaTop(bool value) {
    safeAreaTop.value = value;
    notifyListeners();
  }

  /// Establece el SafeArea inferior directamente.
  void setSafeAreaBottom(bool value) {
    safeAreaBottom.value = value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea superior.
  void toggleSafeAreaTop() {
    safeAreaTop.value = !safeAreaTop.value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea inferior.
  void toggleSafeAreaBottom() {
    safeAreaBottom.value = !safeAreaBottom.value;
    notifyListeners();
  }

  /// Establece el SafeArea izquierdo directamente.
  void setSafeAreaLeft(bool value) {
    safeAreaLeft.value = value;
    notifyListeners();
  }

  /// Establece el SafeArea derecho directamente.
  void setSafeAreaRight(bool value) {
    safeAreaRight.value = value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea izquierdo.
  void toggleSafeAreaLeft() {
    safeAreaLeft.value = !safeAreaLeft.value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea derecho.
  void toggleSafeAreaRight() {
    safeAreaRight.value = !safeAreaRight.value;
    notifyListeners();
  }

  /// ✅ Actualizado: ahora acepta los 4 lados
  void setSafeArea({bool? top, bool? bottom, bool? left, bool? right}) {
    if (top != null) safeAreaTop.value = top;
    if (bottom != null) safeAreaBottom.value = bottom;
    if (left != null) safeAreaLeft.value = left;
    if (right != null) safeAreaRight.value = right;
    notifyListeners();
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/system_ui_service.dart';

class FakeBarsController extends ChangeNotifier {
  static final FakeBarsController instance = FakeBarsController._internal();
  FakeBarsController._internal();

  // --- Colores ---
  final ValueNotifier<Color> statusBarColor = ValueNotifier(Colors.transparent);
  final ValueNotifier<Color> navigationBarColor = ValueNotifier(
    Colors.transparent,
  );
  final ValueNotifier<Color> scaffoldBackgroundColor = ValueNotifier(
    Colors.white,
  );

  // --- Brillo de iconos ---
  final ValueNotifier<Brightness> statusBarIconBrightness = ValueNotifier(
    Brightness.dark,
  );
  final ValueNotifier<Brightness> navigationBarIconBrightness = ValueNotifier(
    Brightness.dark,
  );

  // --- Visibilidad de barras ---
  final ValueNotifier<bool> showStatusBar = ValueNotifier(true);
  final ValueNotifier<bool> showNavigationBar = ValueNotifier(true);
  final ValueNotifier<bool> immersiveMode = ValueNotifier(false);
  final ValueNotifier<bool> isGestureNavigation = ValueNotifier(true);

  // ✅ NUEVO: Control de SafeArea
  final ValueNotifier<bool> safeAreaTop = ValueNotifier(true);
  final ValueNotifier<bool> safeAreaBottom = ValueNotifier(true);

  // ✅ NUEVO: Control de SafeArea lateral
  final ValueNotifier<bool> safeAreaLeft = ValueNotifier(true);
  final ValueNotifier<bool> safeAreaRight = ValueNotifier(true);

  SystemUiOverlayStyle get currentSystemStyle => SystemUiOverlayStyle(
    statusBarColor: statusBarColor.value,
    systemNavigationBarColor: navigationBarColor.value,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: statusBarIconBrightness.value,
    systemNavigationBarIconBrightness: navigationBarIconBrightness.value,
    statusBarBrightness: statusBarIconBrightness.value == Brightness.dark
        ? Brightness.light
        : Brightness.dark,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
  );

  Future<void> init({required String packageName}) async {
    SystemUiService.setChannelName('$packageName/navigation');
    await SystemUiService.initEdgeToEdge();
    notifyListeners();
  }

  // --- Setters de color ---
  void setStatusBarColor(Color color) {
    statusBarColor.value = color;
    notifyListeners();
  }

  void setNavigationBarColor(Color color) {
    navigationBarColor.value = color;
    notifyListeners();
  }

  void setScaffoldBackgroundColor(Color color) {
    scaffoldBackgroundColor.value = color;
    notifyListeners();
  }

  // --- Setters de brillo ---
  void setStatusDarkIcons(bool dark) {
    statusBarIconBrightness.value = dark ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  void setNavigationDarkIcons(bool dark) {
    navigationBarIconBrightness.value = dark
        ? Brightness.dark
        : Brightness.light;
    notifyListeners();
  }

  void setDarkIcons(bool dark) {
    setStatusDarkIcons(dark);
    setNavigationDarkIcons(dark);
  }

  // --- Toggles de visibilidad ---
  void toggleStatusBar() {
    showStatusBar.value = !showStatusBar.value;
    notifyListeners();
  }

  void toggleNavigationBar() {
    showNavigationBar.value = !showNavigationBar.value;
    notifyListeners();
  }

  void toggleImmersive() {
    immersiveMode.value = !immersiveMode.value;
    notifyListeners();
  }

  Future<void> setImmersiveMode(bool enable) async {
    immersiveMode.value = enable;
    notifyListeners();
  }

  void setIsGestureNavigation(bool isGesture) {
    if (isGestureNavigation.value != isGesture) {
      isGestureNavigation.value = isGesture;
      notifyListeners();
    }
  }

  // ✅ NUEVO: Métodos para SafeArea

  /// Establece el SafeArea superior directamente.
  void setSafeAreaTop(bool value) {
    safeAreaTop.value = value;
    notifyListeners();
  }

  /// Establece el SafeArea inferior directamente.
  void setSafeAreaBottom(bool value) {
    safeAreaBottom.value = value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea superior.
  void toggleSafeAreaTop() {
    safeAreaTop.value = !safeAreaTop.value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea inferior.
  void toggleSafeAreaBottom() {
    safeAreaBottom.value = !safeAreaBottom.value;
    notifyListeners();
  }

  /// Establece el SafeArea izquierdo directamente.
  void setSafeAreaLeft(bool value) {
    safeAreaLeft.value = value;
    notifyListeners();
  }

  /// Establece el SafeArea derecho directamente.
  void setSafeAreaRight(bool value) {
    safeAreaRight.value = value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea izquierdo.
  void toggleSafeAreaLeft() {
    safeAreaLeft.value = !safeAreaLeft.value;
    notifyListeners();
  }

  /// Alterna el estado del SafeArea derecho.
  void toggleSafeAreaRight() {
    safeAreaRight.value = !safeAreaRight.value;
    notifyListeners();
  }

  /// ✅ Actualizado: ahora acepta los 4 lados
  void setSafeArea({bool? top, bool? bottom, bool? left, bool? right}) {
    if (top != null) safeAreaTop.value = top;
    if (bottom != null) safeAreaBottom.value = bottom;
    if (left != null) safeAreaLeft.value = left;
    if (right != null) safeAreaRight.value = right;
    notifyListeners();
  }
}
*/
