import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemStyleBuilder {
  SystemStyleBuilder._();

  static SystemUiOverlayStyle build({
    required bool darkStatusBarIcons,
    required bool darkNavigationBarIcons,
  }) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,

      statusBarIconBrightness: darkStatusBarIcons
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarIconBrightness: darkNavigationBarIcons
          ? Brightness.dark
          : Brightness.light,
      statusBarBrightness: darkStatusBarIcons
          ? Brightness.light
          : Brightness.dark,

      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    );
  }
}
