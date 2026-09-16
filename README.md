# Instalación

`ScaffoldCustom` se distribuye como un paquete Flutter mediante GitHub. La instalación permite utilizar el `Scaffold` personalizado y todos sus componentes relacionados con **System Bars, Edge-to-Edge, Safe Area, navegación, modo inmersivo y teclado**.

## Requisitos

Antes de instalar el paquete, asegúrate de tener:

* Flutter instalado y configurado.
* Dart compatible con la versión de Flutter utilizada por el proyecto.
* Un proyecto Flutter existente.
* Android configurado para ejecutar la aplicación si utilizarás las funciones relacionadas con System Bars y Edge-to-Edge.

Puedes comprobar tu instalación ejecutando:

```bash
flutter doctor
```

Para comprobar la versión de Flutter:

```bash
flutter --version
```

---

## Instalar desde GitHub

Agrega `scaffold_custom` en el archivo:

```text
pubspec.yaml
```

Dentro de `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  scaffold_custom:
    git:
      url: https://github.com/ChristianCQF/scaffold_custom.git
      ref: v1.0.6
```

La propiedad `ref` permite fijar una versión específica del paquete.

En este ejemplo se utiliza:

```text
v1.0.6
```

Esto evita que una actualización futura del repositorio modifique inesperadamente el comportamiento de la aplicación.

---

## Instalar las dependencias

Después de modificar `pubspec.yaml`, ejecuta:

```bash
flutter pub get
```

También puedes utilizar:

```bash
flutter pub add scaffold_custom
```

Sin embargo, si necesitas instalar específicamente la versión publicada en GitHub mediante un `ref`, se recomienda declarar la dependencia directamente en `pubspec.yaml`.

---

## Importar el paquete

Una vez instalado, importa el archivo principal:

```dart
import 'package:scaffold_custom/scaffold_custom.dart';
```

Este import proporciona acceso a:

```text
ScaffoldCustom
BarsUIController
```

y a los componentes públicos expuestos por el paquete.

---

# Configuración inicial

Antes de utilizar las funciones avanzadas de `ScaffoldCustom`, se recomienda inicializar `BarsUIController`.

La inicialización debe realizarse después de:

```dart
WidgetsFlutterBinding.ensureInitialized();
```

Ejemplo:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarsUIController.instance.init(
    packageName: 'com.example.myapp',
  );

  runApp(const MyApp());
}
```

## Ejemplo completo de inicialización

```dart
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
      body: const Center(
        child: Text('ScaffoldCustom'),
      ),
    );
  }
}
```

---

# Uso

## Uso básico

La forma más sencilla de utilizar `ScaffoldCustom` es proporcionar únicamente el `body`.

```dart
ScaffoldCustom(
  body: const Center(
    child: Text('Hola mundo'),
  ),
)
```

Esto permite utilizar `ScaffoldCustom` como sustituto directo de un `Scaffold` convencional cuando no se necesita una configuración especial.

---

# Uso con AppBar

`ScaffoldCustom` mantiene compatibilidad con `AppBar`.

```dart
ScaffoldCustom(
  appBar: AppBar(
    title: const Text('Inicio'),
  ),
  body: const Center(
    child: Text('Contenido'),
  ),
)
```

También puedes configurar la apariencia del `AppBar` normalmente:

```dart
ScaffoldCustom(
  appBar: AppBar(
    title: const Text('Mi aplicación'),
    centerTitle: true,
    elevation: 0,
  ),
  body: const Center(
    child: Text('Contenido principal'),
  ),
)
```

---

# Uso con FloatingActionButton

Puedes utilizar un `FloatingActionButton` de la misma forma que en un `Scaffold` convencional.

```dart
ScaffoldCustom(
  appBar: AppBar(
    title: const Text('Productos'),
  ),
  body: const Center(
    child: Text('Lista de productos'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      debugPrint('Agregar producto');
    },
    child: const Icon(Icons.add),
  ),
)
```

---

# Uso con NavigationBar

También puedes utilizar una barra de navegación inferior.

```dart
ScaffoldCustom(
  body: const Center(
    child: Text('Inicio'),
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
)
```

---

# Configuración de System Bars

`ScaffoldCustom` permite controlar independientemente la Status Bar y la Navigation Bar.

```dart
ScaffoldCustom(
  statusBarColor: Colors.blue,
  navigationBarColor: Colors.black,
  body: const Center(
    child: Text('System Bars'),
  ),
)
```

En este caso:

```text
Status Bar    → azul
Navigation Bar → negro
```

---

# System Bars transparentes

Para una interfaz Edge-to-Edge puedes utilizar barras transparentes:

```dart
ScaffoldCustom(
  statusBarColor: Colors.transparent,
  navigationBarColor: Colors.transparent,
  body: const FullScreenContent(),
)
```

Esto permite que el contenido de la aplicación pueda extenderse visualmente detrás de las System Bars.

---

# Control de iconos

Puedes indicar explícitamente el contraste de los iconos.

## Iconos oscuros

```dart
ScaffoldCustom(
  statusBarDarkIcons: true,
  navigationBarDarkIcons: true,
  body: const HomeContent(),
)
```

Esto resulta apropiado cuando el contenido situado detrás de las barras tiene un fondo claro.

---

## Iconos claros

```dart
ScaffoldCustom(
  statusBarDarkIcons: false,
  navigationBarDarkIcons: false,
  body: const HomeContent(),
)
```

Esto resulta apropiado cuando el contenido situado detrás de las barras tiene un fondo oscuro.

---

## Configuración independiente

También puedes controlar cada barra por separado:

```dart
ScaffoldCustom(
  statusBarDarkIcons: true,
  navigationBarDarkIcons: false,
  body: const HomeContent(),
)
```

Resultado:

```text
Status Bar      → iconos oscuros
Navigation Bar  → iconos claros
```

---

# Resolución automática del contraste

Cuando no se establece explícitamente:

```dart
statusBarDarkIcons
```

o:

```dart
navigationBarDarkIcons
```

`ScaffoldCustom` puede utilizar la configuración disponible en `BarsUIController` y el sistema de resolución de contraste implementado por la librería.

Esto permite separar:

```text
Color de la barra
        ↓
Color efectivo
        ↓
Contraste disponible
        ↓
Iconos claros / oscuros
```

---

# Control de visibilidad

Puedes mostrar u ocultar individualmente las System Bars.

```dart
ScaffoldCustom(
  showStatusBar: true,
  showNavigationBar: true,
  body: const HomeContent(),
)
```

Para ocultarlas:

```dart
ScaffoldCustom(
  showStatusBar: false,
  showNavigationBar: false,
  body: const FullScreenContent(),
)
```

También puedes ocultar únicamente una de ellas:

```dart
ScaffoldCustom(
  showStatusBar: false,
  showNavigationBar: true,
  body: const FullScreenContent(),
)
```

---

# Safe Area

El área segura puede configurarse independientemente para cada lado.

```dart
ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: true,
  safeAreaLeft: true,
  safeAreaRight: true,
  body: const HomeContent(),
)
```

Los cuatro lados disponibles son:

```text
top
bottom
left
right
```

---

## Safe Area únicamente superior

```dart
ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: false,
  safeAreaLeft: false,
  safeAreaRight: false,
  body: const HomeContent(),
)
```

Esto resulta útil cuando solamente quieres proteger el contenido de la zona superior.

---

## Safe Area sin protección inferior

```dart
ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: false,
  body: const HomeContent(),
)
```

El contenido podrá utilizar el área inferior disponible.

---

# Edge-to-Edge

Para crear una pantalla que utilice prácticamente toda el área de la ventana:

```dart
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
```

Esta configuración permite que el contenido se dibuje detrás de las System Bars.

---

# Edge-to-Edge respetando el notch

Si quieres utilizar Edge-to-Edge pero mantener protección frente al `display cutout`:

```dart
ScaffoldCustom(
  immersiveMode: true,
  respectNotchInImmersive: true,

  safeAreaTop: false,
  safeAreaBottom: false,

  body: const FullScreenContent(),
)
```

Esto es especialmente útil en dispositivos con:

* notch
* cámara perforada
* display cutout
* pantallas plegables

---

# Edge-to-Edge conservando el área inferior

Puedes conservar la protección inferior:

```dart
ScaffoldCustom(
  immersiveMode: true,
  respectBottomInImmersive: true,

  safeAreaTop: false,
  safeAreaBottom: false,

  body: const FullScreenContent(),
)
```

---

# Edge-to-Edge completo

Puedes combinar ambas protecciones:

```dart
ScaffoldCustom(
  immersiveMode: true,

  respectNotchInImmersive: true,
  respectBottomInImmersive: true,

  safeAreaTop: false,
  safeAreaBottom: false,
  safeAreaLeft: false,
  safeAreaRight: false,

  statusBarColor: Colors.transparent,
  navigationBarColor: Colors.transparent,

  body: const FullScreenContent(),
)
```

---

# Modo inmersivo

Puedes activar el modo inmersivo directamente desde el `ScaffoldCustom`:

```dart
ScaffoldCustom(
  immersiveMode: true,
  body: const FullScreenContent(),
)
```

Para una pantalla normal:

```dart
ScaffoldCustom(
  immersiveMode: false,
  body: const HomeContent(),
)
```

Si el valor es `null`, se utiliza la configuración disponible en `BarsUIController`.

---

# Formularios y teclado

Para formularios puedes activar:

```dart
resizeToAvoidBottomInset: true
```

Ejemplo:

```dart
ScaffoldCustom(
  resizeToAvoidBottomInset: true,

  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Usuario',
          ),
        ),
        const SizedBox(height: 16),
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
```

---

# Ocultar Fake Bars con el teclado

Si la interfaz utiliza barras visuales adicionales o `Fake Bars`, puedes ocultarlas automáticamente cuando aparezca el teclado:

```dart
ScaffoldCustom(
  resizeToAvoidBottomInset: true,
  hideFakeBarsOnKeyboard: true,

  body: const LoginForm(),
)
```

La detección utiliza:

```dart
MediaQuery.viewInsets.bottom
```

Cuando el teclado aparece, `viewInsets.bottom` cambia y `ScaffoldCustom` puede actualizar el estado visual de las barras.

---

# Ejemplo completo: Login

```dart
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      statusBarColor: Colors.transparent,
      navigationBarColor: Colors.transparent,

      statusBarDarkIcons: true,
      navigationBarDarkIcons: true,

      safeAreaTop: true,
      safeAreaBottom: true,

      resizeToAvoidBottomInset: true,
      hideFakeBarsOnKeyboard: true,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              const TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Ingresar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

# BarsUIController

`BarsUIController` permite establecer valores globales que pueden ser utilizados por diferentes instancias de `ScaffoldCustom`.

El controlador se obtiene mediante:

```dart
BarsUIController.instance
```

---

# Configuración global de colores

## Status Bar

```dart
BarsUIController.instance.setStatusBarColor(
  Colors.transparent,
);
```

## Navigation Bar

```dart
BarsUIController.instance.setNavigationBarColor(
  Colors.transparent,
);
```

## Fondo global

```dart
BarsUIController.instance.setScaffoldBackgroundColor(
  Colors.white,
);
```

---

# Configuración global de iconos

Para establecer iconos oscuros:

```dart
BarsUIController.instance.setDarkIcons(true);
```

Para establecer iconos claros:

```dart
BarsUIController.instance.setDarkIcons(false);
```

También puedes configurar cada barra independientemente:

```dart
BarsUIController.instance.setStatusDarkIcons(true);

BarsUIController.instance.setNavigationDarkIcons(false);
```

---

# Configuración global de visibilidad

Puedes alternar la Status Bar:

```dart
BarsUIController.instance.toggleStatusBar();
```

Y la Navigation Bar:

```dart
BarsUIController.instance.toggleNavigationBar();
```

---

# Configuración global del modo inmersivo

Para alternar el modo inmersivo:

```dart
BarsUIController.instance.toggleImmersive();
```

También puedes establecerlo directamente:

```dart
await BarsUIController.instance.setImmersiveMode(true);
```

Para desactivarlo:

```dart
await BarsUIController.instance.setImmersiveMode(false);
```

---

# Configuración global de Safe Area

Puedes configurar cada lado:

```dart
BarsUIController.instance.setSafeAreaTop(true);

BarsUIController.instance.setSafeAreaBottom(true);

BarsUIController.instance.setSafeAreaLeft(true);

BarsUIController.instance.setSafeAreaRight(true);
```

O todos los lados mediante un único método:

```dart
BarsUIController.instance.setSafeArea(
  top: true,
  bottom: true,
  left: true,
  right: true,
);
```

También puedes alternar cada lado:

```dart
BarsUIController.instance.toggleSafeAreaTop();

BarsUIController.instance.toggleSafeAreaBottom();

BarsUIController.instance.toggleSafeAreaLeft();

BarsUIController.instance.toggleSafeAreaRight();
```

---

# Navegación gestual

Puedes indicar que el dispositivo utiliza navegación gestual:

```dart
BarsUIController.instance.setIsGestureNavigation(true);
```

Para navegación mediante botones:

```dart
BarsUIController.instance.setIsGestureNavigation(false);
```

Esta configuración permite que el cálculo del área inferior tenga en cuenta el tipo de navegación utilizado por el dispositivo.

---

# Configuración local vs. global

La configuración de `ScaffoldCustom` tiene prioridad sobre la configuración global.

Por ejemplo, si defines:

```dart
BarsUIController.instance.setStatusBarColor(
  Colors.red,
);
```

todos los `ScaffoldCustom` que no especifiquen un color propio utilizarán esa configuración.

Sin embargo:

```dart
ScaffoldCustom(
  statusBarColor: Colors.blue,
  body: const HomeContent(),
)
```

utilizará:

```text
Status Bar → azul
```

aunque globalmente se haya establecido:

```text
Status Bar → rojo
```

La prioridad es:

```text
ScaffoldCustom
      ↓
BarsUIController
      ↓
Valor predeterminado
```

Los valores definidos directamente en una instancia tienen prioridad sobre los valores globales.

---

# Ejemplo completo: configuración global

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarsUIController.instance.init(
    packageName: 'com.example.myapp',
  );

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

  BarsUIController.instance.setSafeArea(
    top: true,
    bottom: true,
    left: true,
    right: true,
  );

  runApp(const MyApp());
}
```

Posteriormente las pantallas pueden utilizar simplemente:

```dart
ScaffoldCustom(
  body: const HomeContent(),
)
```

---

# Ejemplo completo: configuración global + configuración local

Configuración global:

```dart
BarsUIController.instance.setStatusBarColor(
  Colors.transparent,
);

BarsUIController.instance.setNavigationBarColor(
  Colors.transparent,
);

BarsUIController.instance.setDarkIcons(true);
```

Pantalla normal:

```dart
ScaffoldCustom(
  body: const HomeContent(),
)
```

Pantalla que necesita una configuración diferente:

```dart
ScaffoldCustom(
  statusBarColor: Colors.black,
  navigationBarColor: Colors.black,

  statusBarDarkIcons: false,
  navigationBarDarkIcons: false,

  body: const VideoPlayerPage(),
)
```

De esta forma no es necesario modificar la configuración global cada vez que una pantalla necesita un comportamiento diferente.

---

# Ejemplo completo: aplicación

```dart
import 'package:flutter/material.dart';
import 'package:scaffold_custom/scaffold_custom.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarsUIController.instance.init(
    packageName: 'com.example.myapp',
  );

  BarsUIController.instance.setStatusBarColor(
    Colors.transparent,
  );

  BarsUIController.instance.setNavigationBarColor(
    Colors.transparent,
  );

  BarsUIController.instance.setDarkIcons(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scaffold Custom',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBar: AppBar(
        title: const Text('Scaffold Custom'),
      ),

      body: const Center(
        child: Text(
          'ScaffoldCustom v1.0.6',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
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
```

---

# Ejemplo: pantalla completamente inmersiva

Este escenario es apropiado para interfaces como:

* reproductores de vídeo
* mapas
* galerías
* visualizadores
* juegos
* interfaces Full Screen

```dart
class FullScreenPage extends StatelessWidget {
  const FullScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      immersiveMode: true,

      showStatusBar: false,
      showNavigationBar: false,

      safeAreaTop: false,
      safeAreaBottom: false,
      safeAreaLeft: false,
      safeAreaRight: false,

      statusBarColor: Colors.transparent,
      navigationBarColor: Colors.transparent,

      body: const ColoredBox(
        color: Colors.black,
        child: Center(
          child: Text(
            'Full Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
```

---

# Ejemplo: pantalla Edge-to-Edge con protección del notch

```dart
class EdgeToEdgePage extends StatelessWidget {
  const EdgeToEdgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      immersiveMode: true,

      respectNotchInImmersive: true,
      respectBottomInImmersive: true,

      safeAreaTop: false,
      safeAreaBottom: false,
      safeAreaLeft: false,
      safeAreaRight: false,

      statusBarColor: Colors.transparent,
      navigationBarColor: Colors.transparent,

      body: const EdgeToEdgeContent(),
    );
  }
}
```

En este caso el contenido puede ocupar el área completa, mientras `ScaffoldCustom` mantiene el tratamiento específico del `display cutout` y del área inferior según la configuración indicada.

---

# Ejemplo: orientación horizontal

`ScaffoldCustom` utiliza las métricas actuales de la ventana para recalcular las áreas necesarias cuando cambia la orientación.

No es necesario reconstruir manualmente la configuración.

```dart
ScaffoldCustom(
  safeAreaTop: true,
  safeAreaBottom: true,
  safeAreaLeft: true,
  safeAreaRight: true,

  body: const LandscapeContent(),
)
```

La misma pantalla puede utilizarse en:

```text
Portrait
Landscape
```

y el cálculo de las áreas se adapta a la geometría actual de la ventana.

---

# Ejemplo: pantalla con configuración mínima

Cuando no necesitas controlar ningún aspecto específico:

```dart
ScaffoldCustom(
  body: const HomeContent(),
)
```

Este es el patrón recomendado para la mayoría de las pantallas normales.

---

# Ejemplo: máxima configuración

Cuando una pantalla requiere control completo:

```dart
ScaffoldCustom(
  statusBarColor: Colors.transparent,
  navigationBarColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.black,

  statusBarDarkIcons: false,
  navigationBarDarkIcons: false,

  showStatusBar: true,
  showNavigationBar: true,

  immersiveMode: true,

  safeAreaTop: false,
  safeAreaBottom: false,
  safeAreaLeft: false,
  safeAreaRight: false,

  respectNotchInImmersive: true,
  respectBottomInImmersive: true,

  resizeToAvoidBottomInset: false,
  hideFakeBarsOnKeyboard: true,

  body: const FullScreenContent(),
)
```

Esta configuración proporciona control explícito de:

```text
System Bars
Iconos
Visibilidad
Immersive Mode
Safe Area
Notch
Área inferior
Teclado
Contenido Edge-to-Edge
```

---

# API de referencia

## ScaffoldCustom

```dart
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
```

## BarsUIController

```dart
BarsUIController.instance
```

### Colores

```dart
setStatusBarColor()
setNavigationBarColor()
setScaffoldBackgroundColor()
```

### Iconos

```dart
setStatusDarkIcons()
setNavigationDarkIcons()
setDarkIcons()
```

### Visibilidad

```dart
toggleStatusBar()
toggleNavigationBar()
```

### Immersive

```dart
toggleImmersive()
setImmersiveMode()
```

### Navegación

```dart
setIsGestureNavigation()
```

### Safe Area

```dart
setSafeAreaTop()
setSafeAreaBottom()
setSafeAreaLeft()
setSafeAreaRight()

setSafeArea()

toggleSafeAreaTop()
toggleSafeAreaBottom()
toggleSafeAreaLeft()
toggleSafeAreaRight()
```

### Inicialización

```dart
init()
```
