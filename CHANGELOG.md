Scaffold Custom

ScaffoldCustom es un Scaffold avanzado para Flutter diseñado para
controlar de forma precisa el comportamiento de las System Bars,
Edge-to-Edge, Safe Area, modo inmersivo, notch/display
cutout, navegación gestual o mediante botones y el comportamiento
visual cuando aparece el teclado.

La librería extiende el comportamiento del Scaffold de Flutter
manteniendo una API familiar y añadiendo controles específicos para
dispositivos Android modernos y diferentes configuraciones de
navegación.

Características

📱 Edge-to-Edge

🔝 Control de Status Bar

🔽 Control de Navigation Bar

🎨 Colores independientes para Status Bar y Navigation Bar

🌓 Control de iconos claros/oscuros

🤖 Resolución automática de contraste de iconos

👆 Soporte para navegación gestual

🔘 Soporte para navegación mediante botones

🖥️ Detección de posición de Navigation Bar

🕶️ Modo inmersivo

📐 Safe Area configurable por lado

🔲 Control independiente de top, bottom, left y right

📱 Soporte para notch y display cutout

⌨️ Manejo del teclado

🧩 Ocultación de barras falsas al abrir el teclado

🔄 Actualización al cambiar orientación o métricas

♻️ Actualización al volver a la aplicación

🎛️ Configuración local por ScaffoldCustom

🌐 Configuración global mediante BarsUIController

🧱 Compatible con AppBar

➕ Compatible con FloatingActionButton

🔽 Compatible con BottomNavigationBar

🧩 Arquitectura modular

Contenido

Instalación

Versión

Uso

ScaffoldCustom

Colores

Iconos de las System Bars

Visibilidad de las barras

Safe Area

Modo inmersivo

Teclado

BarsUIController

Configuración global

Prioridad de configuración

Inicialización

Ejemplo completo

Arquitectura

Filosofía del sistema

Instalación

Agrega scaffold_custom directamente desde GitHub en pubspec.yaml:

dependencies:
  scaffold_custom:
    git:
      url: https://github.com/ChristianCQF/scaffold_custom.git
      ref: v1.0.6

Después ejecuta:

flutter pub get

Versión

Versión utilizada en este README:

v1.0.6

Repositorio:

https://github.com/ChristianCQF/scaffold_custom.git

Uso

Importa la librería:

import 'package:scaffold_custom/scaffold_custom.dart';

El uso básico requiere únicamente body:

ScaffoldCustom(
  body: const Center(
    child: Text('Hola mundo'),
  ),
)

ScaffoldCustom

La clase principal es:

ScaffoldCustom

Su API mantiene elementos habituales de un Scaffold:

ScaffoldCustom(
  body: const MyBody(),

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
    ],
  ),
)

Propiedades

Contenido

Propiedad                Tipo                     Descripción

body                   Widget                 Contenido principal
appBar                 PreferredSizeWidget?   AppBar u otro widget compatible
floatingActionButton   Widget?                Botón flotante
bottomNavigationBar    Widget?                Barra inferior

body es obligatorio.

Colores

Puedes controlar de forma independiente el color de cada área:

ScaffoldCustom(
  statusBarColor: Colors.transparent,
  navigationBarColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,

  body: const MyBody(),
)

Propiedades:

statusBarColor
navigationBarColor
scaffoldBackgroundColor

Status Bar

statusBarColor: Colors.blue,

Navigation Bar

navigationBarColor: Colors.black,

Fondo del Scaffold

scaffoldBackgroundColor: Colors.white,

Iconos de las System Bars

Puedes indicar explícitamente si los iconos deben ser claros u oscuros:

ScaffoldCustom(
  statusBarDarkIcons: true,
  navigationBarDarkIcons: true,

  body: const MyBody(),
)

Iconos oscuros

statusBarDarkIcons: true
navigationBarDarkIcons: true

Iconos claros

statusBarDarkIcons: false
navigationBarDarkIcons: false

Si no se establece una preferencia local, ScaffoldCustom utiliza la
configuración disponible en BarsUIController.

Además, la implementación calcula el color efectivo de las barras y
dispone de un resolver para determinar el contraste de los iconos cuando
corresponde.

Visibilidad de las barras

Puedes controlar independientemente la visibilidad:

ScaffoldCustom(
  showStatusBar: true,
  showNavigationBar: true,

  body: const MyBody(),
)

Para ocultar una barra:

ScaffoldCustom(
  showStatusBar: false,
  showNavigationBar: false,

  body: const MyBody(),
)

Propiedades:

showStatusBar
showNavigationBar

Safe Area

ScaffoldCustom permite controlar individualmente los cuatro lados del
área segura.

ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: true,
  safeAreaLeft: true,
  safeAreaRight: true,

  body: const MyBody(),
)

Los lados disponibles son:

top
bottom
left
right

Puedes desactivar solamente la protección superior:

ScaffoldCustom(
  safeAreaTop: false,
  safeAreaBottom: true,
  safeAreaLeft: true,
  safeAreaRight: true,

  body: const MyBody(),
)

O controlar únicamente el área inferior:

ScaffoldCustom(
  safeAreaBottom: false,
  body: const MyBody(),
)

La implementación calcula las áreas seguras teniendo en cuenta la
visibilidad de las barras, el modo inmersivo y las opciones relacionadas
con notch y espacio inferior.

Modo inmersivo

Activa el modo inmersivo mediante:

ScaffoldCustom(
  immersiveMode: true,
  body: const MyBody(),
)

Puedes controlar adicionalmente el comportamiento frente al
notch/display cutout:

ScaffoldCustom(
  immersiveMode: true,
  respectNotchInImmersive: true,
  body: const MyBody(),
)

También puedes conservar el espacio inferior:

ScaffoldCustom(
  immersiveMode: true,
  respectBottomInImmersive: true,
  body: const MyBody(),
)

Combinación:

ScaffoldCustom(
  immersiveMode: true,
  respectNotchInImmersive: true,
  respectBottomInImmersive: true,
  body: const MyBody(),
)

Parámetros

Propiedad                               Valor por defecto Descripción

immersiveMode                                    null Activa o desactiva el
modo inmersivo

respectNotchInImmersive                         false Respeta el
notch/display cutout

Teclado

ScaffoldCustom permite controlar el comportamiento de
redimensionamiento cuando aparece el teclado.

resizeToAvoidBottomInset

ScaffoldCustom(
  resizeToAvoidBottomInset: true,
  body: const MyForm(),
)

Por defecto:

resizeToAvoidBottomInset: false

Ocultar barras falsas con el teclado

Puedes ocultar las barras visuales adicionales mientras el teclado está
abierto:

ScaffoldCustom(
  hideFakeBarsOnKeyboard: true,
  body: const MyForm(),
)

Propiedad:

hideFakeBarsOnKeyboard

Por defecto:

false

La implementación detecta la apertura del teclado mediante
MediaQuery.viewInsets.bottom.

BarsUIController

BarsUIController permite mantener una configuración global de las
barras del sistema.

El controlador utiliza una instancia singleton:

BarsUIController.instance

Puedes utilizarlo para configurar:

Status Bar
Navigation Bar
Scaffold Background
Icon Brightness
Visibilidad
Immersive Mode
Safe Area
Navegación gestual

Configuración global

Status Bar

BarsUIController.instance.setStatusBarColor(
  Colors.transparent,
);

Navigation Bar

BarsUIController.instance.setNavigationBarColor(
  Colors.transparent,
);

Fondo

BarsUIController.instance.setScaffoldBackgroundColor(
  Colors.white,
);

Iconos globales

Para configurar ambas barras:

BarsUIController.instance.setDarkIcons(true);

Iconos claros:

BarsUIController.instance.setDarkIcons(false);

También puedes configurar cada barra por separado:

BarsUIController.instance.setStatusDarkIcons(true);

BarsUIController.instance.setNavigationDarkIcons(false);

Visibilidad global

Puedes alternar la Status Bar:

BarsUIController.instance.toggleStatusBar();

Navigation Bar:

BarsUIController.instance.toggleNavigationBar();

Modo inmersivo:

BarsUIController.instance.toggleImmersive();

También puedes establecer directamente el modo inmersivo:

await BarsUIController.instance.setImmersiveMode(true);

Safe Area global

Puedes configurar cada lado individualmente:

BarsUIController.instance.setSafeAreaTop(true);

BarsUIController.instance.setSafeAreaBottom(true);

BarsUIController.instance.setSafeAreaLeft(true);

BarsUIController.instance.setSafeAreaRight(true);

También puedes configurar los cuatro lados mediante un único método:

BarsUIController.instance.setSafeArea(
  top: true,
  bottom: true,
  left: true,
  right: true,
);

También es posible alternar cada lado:

BarsUIController.instance.toggleSafeAreaTop();

BarsUIController.instance.toggleSafeAreaBottom();

BarsUIController.instance.toggleSafeAreaLeft();

BarsUIController.instance.toggleSafeAreaRight();

Navegación gestual

El controlador mantiene el estado de navegación gestual:

BarsUIController.instance.setIsGestureNavigation(true);

Para navegación mediante botones:

BarsUIController.instance.setIsGestureNavigation(false);

La librería utiliza además el servicio del sistema para determinar si el
dispositivo dispone de navegación mediante botones.

Inicialización

Antes de ejecutar la aplicación puedes inicializar el controlador:

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarsUIController.instance.init(
    packageName: 'com.example.myapp',
  );

  runApp(const MyApp());
}

La inicialización configura el canal utilizado por el servicio de
navegación y activa la configuración Edge-to-Edge.

Prioridad de configuración

ScaffoldCustom permite configurar los valores directamente en cada
instancia.

Cuando una propiedad se establece en el widget, ese valor tiene
prioridad sobre la configuración global del BarsUIController.

Ejemplo global:

BarsUIController.instance.setStatusBarColor(
  Colors.red,
);

Pero un Scaffold específico puede utilizar:

ScaffoldCustom(
  statusBarColor: Colors.blue,
  body: const MyBody(),
)

En ese ScaffoldCustom se utilizará el valor definido localmente.

Este mecanismo permite combinar:

Configuración global
        +
Configuración específica por pantalla

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

      immersiveMode: false,

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

Ejemplo: pantalla Edge-to-Edge

Para una pantalla que ocupe completamente el área disponible:

ScaffoldCustom(
  immersiveMode: true,

  safeAreaTop: false,
  safeAreaBottom: false,
  safeAreaLeft: false,
  safeAreaRight: false,

  statusBarColor: Colors.transparent,
  navigationBarColor: Colors.transparent,

  body: const FullScreenContent(),
)

Si quieres conservar la protección del notch:

ScaffoldCustom(
  immersiveMode: true,
  respectNotchInImmersive: true,

  safeAreaTop: false,
  safeAreaBottom: false,

  body: const FullScreenContent(),
)

Ejemplo: formulario con teclado

ScaffoldCustom(
  resizeToAvoidBottomInset: true,
  hideFakeBarsOnKeyboard: true,

  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Usuario',
          ),
        ),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
          ),
        ),
      ],
    ),
  ),
)

Arquitectura

La librería separa las responsabilidades mediante componentes
especializados:

ScaffoldCustom
        │
        ├── BarsUIController
        │
        ├── BarColorResolver
        │
        ├── ScaffoldLayoutCalculator
        │
        ├── ScaffoldWidgetBuilder
        │
        ├── SystemStyleBuilder
        │
        ├── SystemUiService
        │
        ├── KeyboardInsensitive
        │
        └── LifecycleObserver

ScaffoldCustom

Coordina la construcción del Scaffold y aplica la configuración actual
de la interfaz del sistema.

BarsUIController

Mantiene la configuración global de:

colores

brillo de iconos

visibilidad

modo inmersivo

Safe Area

navegación gestual

BarColorResolver

Determina los colores efectivos de las System Bars y permite resolver el
contraste de los iconos.

ScaffoldLayoutCalculator

Calcula:

posición de Navigation Bar

insets

Safe Areas

tamaño de Navigation Bar

ScaffoldWidgetBuilder

Construye:

body

bottom navigation

barras visuales adicionales

SystemStyleBuilder

Construye el SystemUiOverlayStyle utilizado por Flutter.

SystemUiService

Gestiona la comunicación con la configuración de UI del sistema.

KeyboardInsensitive

Permite mantener independientes las barras visuales del comportamiento
del teclado.

LifecycleObserver

Participa en la actualización del estado cuando cambia el ciclo de vida
de la aplicación.

Filosofía del sistema

ScaffoldCustom separa tres conceptos principales:

                 SCAFFOLD CUSTOM
                       │
        ┌──────────────┼──────────────┐
        │              │              │
      SYSTEM          LAYOUT        CONTENT
        │              │              │
   Status Bar     Safe Area         Body
   Navigation    Insets            AppBar
   Immersive     Notch             FAB
   Iconos        Navigation        Bottom Bar
        │              │              │
        └──────────────┴──────────────┘

System UI

Controla la apariencia y comportamiento de:

Status Bar
Navigation Bar
Iconos
Immersive Mode

Layout

Controla:

Safe Area
Insets
Notch
Navigation Bar
Teclado
Orientación

Content

Mantiene los elementos habituales de Flutter:

Body
AppBar
FloatingActionButton
BottomNavigationBar

API

ScaffoldCustom

ScaffoldCustom(
  body: Widget,
  appBar: PreferredSizeWidget?,
  floatingActionButton: Widget?,
  bottomNavigationBar: Widget?,

  statusBarColor: Color?,
  navigationBarColor: Color?,
  scaffoldBackgroundColor: Color?,

  statusBarDarkIcons: bool?,
  navigationBarDarkIcons: bool?,

  showStatusBar: bool?,
  showNavigationBar: bool?,
  immersiveMode: bool?,

  safeAreaTop: bool?,
  safeAreaBottom: bool?,
  safeAreaLeft: bool?,
  safeAreaRight: bool?,

  respectNotchInImmersive: bool,
  respectBottomInImmersive: bool,

  resizeToAvoidBottomInset: bool,
  hideFakeBarsOnKeyboard: bool,
)

BarsUIController

BarsUIController.instance

Colores

setStatusBarColor()
setNavigationBarColor()
setScaffoldBackgroundColor()

Iconos

setStatusDarkIcons()
setNavigationDarkIcons()
setDarkIcons()

Visibilidad

toggleStatusBar()
toggleNavigationBar()

Immersive

toggleImmersive()
setImmersiveMode()

Navegación

setIsGestureNavigation()

Safe Area

setSafeAreaTop()
setSafeAreaBottom()
setSafeAreaLeft()
setSafeAreaRight()
setSafeArea()

toggleSafeAreaTop()
toggleSafeAreaBottom()
toggleSafeAreaLeft()
toggleSafeAreaRight()

Inicialización

init()

Recomendaciones de uso

Para una pantalla normal

ScaffoldCustom(
  body: const HomeContent(),
)

Para controlar System Bars

ScaffoldCustom(
  statusBarColor: Colors.transparent,
  navigationBarColor: Colors.transparent,
  statusBarDarkIcons: true,
  navigationBarDarkIcons: true,
  body: const HomeContent(),
)

Para Edge-to-Edge

ScaffoldCustom(
  immersiveMode: true,
  body: const FullScreenContent(),
)

Para controlar Safe Area

ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: false,
  body: const HomeContent(),
)

Para formularios

ScaffoldCustom(
  resizeToAvoidBottomInset: true,
  hideFakeBarsOnKeyboard: true,
  body: const LoginForm(),
)

Para configuración global

BarsUIController.instance.setDarkIcons(true);

Arquitectura de configuración

La configuración puede realizarse en dos niveles:

                  CONFIGURACIÓN
                       │
             ┌─────────┴─────────┐
             │                   │
          GLOBAL                LOCAL
             │                   │
   BarsUIController         ScaffoldCustom
             │                   │
             └─────────┬─────────┘
                       │
                       ▼
                Valor efectivo

Esto permite definir una configuración general para toda la aplicación y
sobrescribirla individualmente en determinadas pantallas.
