import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SystemUiService {
  SystemUiService._();

  //static const _channel = MethodChannel('com.example.store_sof/navigation');
  static String _channelName = 'com.example.store_sof/navigation';

  static void setChannelName(String name) {
    _channelName = name;
  }

  static MethodChannel get _channel => MethodChannel(_channelName);

  /// Aplica el modo inmersivo o edge-to-edge.
  static Future<void> applySystemUiMode({required bool isImmersive}) async {
    if (kIsWeb) return;
    if (isImmersive) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  /// Consulta si el dispositivo Android tiene botones de navegación física/virtual.
  static Future<bool> hasNavigationButtons() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return false;
    try {
      return await _channel
              .invokeMethod<bool>('hasNavigationButtons')
              .timeout(const Duration(seconds: 2)) ??
          false;
    } catch (_) {
      return false;
    }
  }

  /// Inicialización base edge-to-edge para iOS y Android.
  static Future<void> initEdgeToEdge() async {
    if (kIsWeb) return;
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }
}
