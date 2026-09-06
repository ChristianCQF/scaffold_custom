package com.example.example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Delegamos la configuración de la ventana a nuestra clase separada
        ScaffoldCustom.setupWindow(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Delegamos el registro del canal de métodos a nuestra clase separada
        ScaffoldCustom.setupNavigationChannel(flutterEngine, this)
    }
}