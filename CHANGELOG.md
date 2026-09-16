scaffold_custom

Widget ScaffoldCustom para Flutter orientado a controlar de forma
centralizada el edge-to-edge, las barras del sistema, SafeArea,
modo inmersivo, navegación gestual/3 botones y comportamiento del
teclado.

Repositorio: https://github.com/ChristianCQF/scaffold_custom
Versión: v1.0.6

Características

Edge-to-edge.

Control del status bar.

Control del navigation bar.

Colores independientes para ambas barras.

Detección automática de contraste para los iconos.

Iconos claros u oscuros mediante configuración explícita.

Soporte para navegación gestual y navegación con botones.

Modo inmersivo.

SafeArea configurable por cada lado:

top

bottom

left

right

Control independiente de notch/cutout en modo inmersivo.

Control del espacio inferior en modo inmersivo.

Control de resizeToAvoidBottomInset.

Opción para ocultar las barras falsas cuando aparece el teclado.

Compatible con AppBar, FloatingActionButton y
BottomNavigationBar.

Arquitectura modular para cálculo de layout, resolución de colores y
estilos del sistema.

La API pública de ScaffoldCustom expone body, appBar,
floatingActionButton, bottomNavigationBar, colores, brillo de
iconos, visibilidad de barras, modo inmersivo y configuración de áreas
seguras.

Instalación

Agrega la dependencia directamente desde GitHub en pubspec.yaml:

dependencies:
  scaffold_custom:
    git:
      url: https://github.com/ChristianCQF/scaffold_custom.git
      ref: v1.0.6

Después ejecuta:

flutter pub get

Importación

import 'package:scaffold_custom/scaffold_custom.dart';

Uso básico

El uso mínimo requiere únicamente body:

import 'package:flutter/material.dart';
import 'package:scaffold_custom/scaffold_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: const Center(
        child: Text('Hola mundo'),
      ),
    );
  }
}

Uso recomendado

Un ejemplo con AppBar, FloatingActionButton, BottomNavigationBar y
configuración de las barras del sistema:

import 'package:flutter/material.dart';
import 'package:scaffold_custom/scaffold_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      statusBarColor: Colors.transparent,
      navigationBarColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,

      statusBarDarkIcons: true,
      navigationBarDarkIcons: true,

      showStatusBar: true,
      showNavigationBar: true,

      immersiveMode: false,

      safeAreaTop: true,
      safeAreaBottom: true,
      safeAreaLeft: true,
      safeAreaRight: true,

      body: const Center(
        child: Text('Contenido'),
      ),

      appBar: AppBar(
        title: const Text('Inicio'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

API de ScaffoldCustom

Contenido

Propiedad                Tipo                     Descripción

body                   Widget                 Contenido principal. Requerido
appBar                 PreferredSizeWidget?   AppBar u otro widget compatible
floatingActionButton   Widget?                Botón flotante
bottomNavigationBar    Widget?                Barra de navegación inferior

Colores

Propiedad                   Tipo       Descripción

statusBarColor            Color?   Color del área de la barra de estado
navigationBarColor        Color?   Color del área de navegación
scaffoldBackgroundColor   Color?   Fondo del Scaffold

Si no se especifica un valor localmente, ScaffoldCustom utiliza el
valor configurado mediante BarsUIController.

Iconos de las barras

ScaffoldCustom(
  statusBarDarkIcons: true,
  navigationBarDarkIcons: false,
  body: const MyBody(),
)

true: iconos oscuros.

false: iconos claros.

null: utiliza la configuración global del controlador.

La implementación utiliza el color efectivo de cada barra para resolver
automáticamente el contraste cuando no existe una preferencia explícita.

Visibilidad de las barras

ScaffoldCustom(
  showStatusBar: true,
  showNavigationBar: true,
  body: const MyBody(),
)

También puedes ocultarlas:

ScaffoldCustom(
  showStatusBar: false,
  showNavigationBar: false,
  body: const MyBody(),
)

Modo inmersivo

ScaffoldCustom(
  immersiveMode: true,
  body: const MyBody(),
)

En modo inmersivo puedes decidir si el contenido debe respetar el
notch/cutout y el espacio inferior:

ScaffoldCustom(
  immersiveMode: true,
  respectNotchInImmersive: true,
  respectBottomInImmersive: true,
  body: const MyBody(),
)

Parámetros

Propiedad                               Valor por defecto Función

immersiveMode                                    null Activa/desactiva el
modo inmersivo

respectNotchInImmersive                         false Conserva protección
frente a notch/cutout

SafeArea configurable

Puedes controlar cada lado independientemente:

ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: true,
  safeAreaLeft: true,
  safeAreaRight: true,
  body: const MyBody(),
)

Por ejemplo, para permitir que el contenido ocupe toda la parte
superior:

ScaffoldCustom(
  safeAreaTop: false,
  safeAreaBottom: true,
  body: const MyBody(),
)

Los cuatro lados disponibles son:

top
bottom
left
right

Teclado

resizeToAvoidBottomInset

ScaffoldCustom(
  resizeToAvoidBottomInset: true,
  body: const MyForm(),
)

Por defecto:

resizeToAvoidBottomInset: false

Ocultar barras falsas al abrir el teclado

ScaffoldCustom(
  hideFakeBarsOnKeyboard: true,
  body: const MyForm(),
)

Esto puede ser útil cuando un formulario abre el teclado y no quieres
que las barras visuales adicionales interfieran con el área visible.

Configuración global con BarsUIController

ScaffoldCustom puede utilizar la configuración global de
BarsUIController cuando una propiedad no se establece directamente en
el widget.

El controlador expone valores para:

Color de status bar.

Color de navigation bar.

Color de fondo del Scaffold.

Brillo de iconos.

Visibilidad de barras.

Modo inmersivo.

Navegación gestual.

SafeArea superior.

SafeArea inferior.

SafeArea izquierda.

SafeArea derecha.

Ejemplo:

BarsUIController.instance.setStatusBarColor(
  Colors.transparent,
);

BarsUIController.instance.setNavigationBarColor(
  Colors.transparent,
);

BarsUIController.instance.setScaffoldBackgroundColor(
  Colors.white,
);

BarsUIController.instance.setDarkIcons(true);

Para SafeArea:

BarsUIController.instance.setSafeArea(
  top: true,
  bottom: true,
  left: true,
  right: true,
);

También puedes modificar lados individualmente:

BarsUIController.instance.setSafeAreaTop(true);
BarsUIController.instance.setSafeAreaBottom(false);
BarsUIController.instance.setSafeAreaLeft(true);
BarsUIController.instance.setSafeAreaRight(true);

Inicialización

El controlador permite inicializar la integración con el servicio de UI
del sistema:

await BarsUIController.instance.init(
  packageName: 'com.example.myapp',
);

Se recomienda realizar la inicialización antes de ejecutar la
aplicación:

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarsUIController.instance.init(
    packageName: 'com.example.myapp',
  );

  runApp(const MyApp());
}

Ejemplo completo

import 'package:flutter/material.dart';
import 'package:scaffold_custom/scaffold_custom.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarsUIController.instance.init(
    packageName: 'com.example.myapp',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      statusBarColor: Colors.transparent,
      navigationBarColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,

      statusBarDarkIcons: true,
      navigationBarDarkIcons: true,

      showStatusBar: true,
      showNavigationBar: true,

      safeAreaTop: true,
      safeAreaBottom: true,
      safeAreaLeft: true,
      safeAreaRight: true,

      resizeToAvoidBottomInset: false,
      hideFakeBarsOnKeyboard: false,

      appBar: AppBar(
        title: const Text('Scaffold Custom'),
      ),

      body: const Center(
        child: Text(
          'ScaffoldCustom v1.0.6',
        ),
      ),
    );
  }
}

Prioridad de configuración

Cuando existe una configuración tanto en ScaffoldCustom como en
BarsUIController, el valor definido directamente en el widget tiene
prioridad.

Ejemplo:

ScaffoldCustom(
  statusBarColor: Colors.blue,
  body: const MyBody(),
)

Aunque globalmente se haya configurado otro color:

BarsUIController.instance.setStatusBarColor(
  Colors.red,
);

para ese ScaffoldCustom se utilizará Colors.blue.

Arquitectura

La implementación separa responsabilidades mediante componentes
especializados:

ScaffoldCustom
├── BarsUIController
├── BarColorResolver
├── KeyboardInsensitive
├── LifecycleObserver
├── ScaffoldLayoutCalculator
├── ScaffoldWidgetBuilder
├── SystemStyleBuilder
└── SystemUiService

ScaffoldCustom calcula los insets, áreas seguras, posición de la barra
de navegación y colores efectivos antes de construir el Scaffold.

Compatibilidad

La librería está diseñada para aplicaciones Flutter que necesiten un
control más preciso sobre:

Edge-to-edge.

Status bar.

Navigation bar.

SafeArea.

Notch y display cutouts.

Navegación gestual.

Navegación mediante botones.

Modo inmersivo.

Teclado.

Dependencia

scaffold_custom:
  git:
    url: https://github.com/ChristianCQF/scaffold_custom.git
    ref: v1.0.6

Versión

v1.0.6

