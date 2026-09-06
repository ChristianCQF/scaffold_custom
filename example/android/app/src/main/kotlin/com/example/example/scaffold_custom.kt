package com.example.example

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.os.Build
import android.provider.Settings
import android.view.WindowManager
import androidx.core.view.WindowCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object ScaffoldCustom {

    private const val CHANNEL = "com.example.example/navigation"

    /**
     * Configura la ventana de la Activity para bordes extendidos, 
     * barras transparentes y modo de recorte (notch).
     */
    fun setupWindow(activity: Activity) {
        WindowCompat.setDecorFitsSystemWindows(activity.window, false)
        activity.window.statusBarColor = Color.TRANSPARENT
        activity.window.navigationBarColor = Color.TRANSPARENT

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            activity.window.isStatusBarContrastEnforced = false
            activity.window.isNavigationBarContrastEnforced = false
        }

        val params = activity.window.attributes
        params.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
        activity.window.attributes = params
    }

    /**
     * Registra el MethodChannel para comunicar el estado de la navegación a Flutter.
     */
    fun setupNavigationChannel(flutterEngine: FlutterEngine, activity: Activity) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                when (call.method) {
                    "hasNavigationButtons" -> {
                        // true = hay botones (hay que pintar la barra fake)
                        // false = gestos (no pintar)
                        result.success(!isGestureNavigation(activity))
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Método primario: lee el resource interno que el propio Android usa
     * para decidir el modo de navegación (0 = 3 botones, 1 = 2 botones, 2 = gestos).
     */
    private fun getNavBarInteractionMode(context: Context): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            try {
                val resourceId = context.resources.getIdentifier(
                    "config_navBarInteractionMode", "integer", "android"
                )
                if (resourceId > 0) context.resources.getInteger(resourceId) else -1
            } catch (e: Exception) {
                -1
            }
        } else -1
    }

    /**
     * Determina si la navegación por gestos está activa.
     */
    private fun isGestureNavigation(context: Context): Boolean {
        val mode = getNavBarInteractionMode(context)
        if (mode == 2) return true
        if (mode == 0 || mode == 1) {
            return isGestureNavigationBySettings(context)
        }
        return isGestureNavigationBySettings(context)
    }

    /**
     * Detecta navegación por gestos vía Settings (fallback para Android < Q 
     * o cuando el resource del OEM no es confiable).
     */
    private fun isGestureNavigationBySettings(context: Context): Boolean {
        // Clave estándar AOSP en Android 10+
        try {
            val navBarMode = Settings.Secure.getString(context.contentResolver, "navigation_mode")
            if ("2" == navBarMode) return true
            if ("0" == navBarMode || "1" == navBarMode) return false
        } catch (e: Exception) {
            // Continuar con fallbacks específicos de OEM
        }

        // Huawei / Honor EMUI
        getGlobalIntSetting(context, "navigationbar_is_min")?.let { if (it == 1) return true }
        getSecureIntSetting(context, "secure_gesture_navigation")?.let { if (it == 1) return true }
        
        // Xiaomi MIUI
        getGlobalIntSetting(context, "force_fsg_nav_bar")?.let { if (it == 1) return true }
        
        // Samsung One UI
        getSecureIntSetting(context, "navigation_gesture_on")?.let { if (it == 1) return true }

        return false
    }

    private fun getSecureIntSetting(context: Context, key: String): Int? {
        return try {
            Settings.Secure.getInt(context.contentResolver, key)
        } catch (e: Exception) {
            null
        }
    }

    private fun getGlobalIntSetting(context: Context, key: String): Int? {
        return try {
            Settings.Global.getInt(context.contentResolver, key)
        } catch (e: Exception) {
            null
        }
    }
}