import 'package:flutter/widgets.dart';

/// Mixin que gestiona automáticamente el registro y desregistro
/// del observador del ciclo de vida de la aplicación.
mixin LifecycleObserverMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
