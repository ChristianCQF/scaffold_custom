// Imports Android
import android.os.Build
import android.os.Bundle
import android.graphics.Color
import android.view.WindowManager
import android.provider.Settings
import androidx.core.view.WindowCompat

// Imports Flutter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "com.example.flutter_application_3/navigation"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        WindowCompat.setDecorFitsSystemWindows(window, false)
        window.statusBarColor = Color.TRANSPARENT
        window.navigationBarColor = Color.TRANSPARENT

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            window.isStatusBarContrastEnforced = false
            window.isNavigationBarContrastEnforced = false
        }

        // Fix: modificar attributes directamente a veces no aplica bien.
        val params = window.attributes
        params.layoutInDisplayCutoutMode =
            WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
        window.attributes = params
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                when (call.method) {
                    "hasNavigationButtons" -> {
                        // true = 3 (o 2) botones -> hay que pintar la barra fake
                        // false = gestos -> no pintar
                        result.success(!isGestureNavigation())
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Método primario: lee el resource interno que el propio Android usa
     * para decidir el modo de navegación (0 = 3 botones, 1 = 2 botones,
     * 2 = gestos). Es la fuente de verdad, no una heurística de insets.
     *
     * (adaptado desde un módulo React Native equivalente).
     */
    private fun getNavBarInteractionMode(): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            try {
                val resourceId = resources.getIdentifier(
                    "config_navBarInteractionMode", "integer", "android"
                )
                if (resourceId > 0) resources.getInteger(resourceId) else -1
            } catch (e: Exception) {
                -1
            }
        } else -1
    }

    /**
     * Determina si la navegación por gestos está activa.
     * Prioridad:
     *   1. config_navBarInteractionMode == 2 -> gestos confirmado
     *   2. Si el resource no confirma gestos (algunos OEMs no lo actualizan,
     *      ej. Huawei Mate 30 Pro), se consulta Settings como respaldo,
     *      incluyendo claves específicas de varios fabricantes.
     */
    private fun isGestureNavigation(): Boolean {
        val mode = getNavBarInteractionMode()
        if (mode == 2) return true
        if (mode == 0 || mode == 1) {
            // El resource confirmó explícitamente botones (2 o 3),
            // pero igual verificamos Settings por si el OEM lo contradice.
            return isGestureNavigationBySettings()
        }
        // mode == -1: no se pudo leer el resource (pre-Q o excepción)
        return isGestureNavigationBySettings()
    }

    // Detecta navegación por gestos vía Settings. Se usa como:
    //   - Único método en Android < Q.
    //   - Respaldo en Android Q+ cuando config_navBarInteractionMode
    //     no confirma gestos, ya que algunos firmwares OEM dejan ese
    //     resource en su valor por defecto (0) incluso con gestos activos.
    private fun isGestureNavigationBySettings(): Boolean {
        // Clave estándar AOSP en Android 10+. "2" = gestos, "0" = 3 botones,
        // "1" = 2 botones.
        try {
            val navBarMode = Settings.Secure.getString(contentResolver, "navigation_mode")
            if ("2" == navBarMode) return true
            if ("0" == navBarMode || "1" == navBarMode) return false
        } catch (e: Exception) {
            // Continuar con fallbacks específicos de OEM
        }

        // Huawei / Honor EMUI: se escribe en Settings.Global al colapsar
        // la barra al modo gestos. 1 = gestos activos.
        getGlobalIntSetting("navigationbar_is_min")?.let { return it == 1 }

        // Huawei / Honor EMUI (clave alternativa en algunas versiones).
        getSecureIntSetting("secure_gesture_navigation")?.let { return it == 1 }

        // Xiaomi MIUI: 1 cuando el "full-screen gesture nav bar" está activo.
        getGlobalIntSetting("force_fsg_nav_bar")?.let { return it == 1 }

        // Samsung One UI: 1 cuando el usuario activa "Swipe gestures".
        getSecureIntSetting("navigation_gesture_on")?.let { return it == 1 }

        return false
    }

    private fun getSecureIntSetting(key: String): Int? {
        return try {
            Settings.Secure.getInt(contentResolver, key)
        } catch (e: Exception) {
            null
        }
    }

    private fun getGlobalIntSetting(key: String): Int? {
        return try {
            Settings.Global.getInt(contentResolver, key)
        } catch (e: Exception) {
            null
        }
    }
}
