// Importa el paquete principal de Flutter (Material Design).
import 'package:flutter/material.dart';

// Punto de entrada de la aplicación.
void main() {
  // Ejecuta la aplicación llamando al widget principal.
  runApp(const MyApp());
}

// Define la clase MyApp como un StatelessWidget (no cambia su estado interno).
class MyApp extends StatelessWidget {
  // Constructor constante de la clase.
  const MyApp({super.key});

  // Método que construye la interfaz visual de la app.
  @override
  Widget build(BuildContext context) {
    // Retorna un MaterialApp que envuelve toda la aplicación.
    return MaterialApp(
      // Oculta la etiqueta de "DEBUG" en la esquina superior derecha.
      debugShowCheckedModeBanner: false,
      // Título interno de la aplicación.
      title: 'Formulario Correo UAE',
      // Define el color principal de la app (Azul).
      theme: ThemeData(
        // Aplica el esquema de colores basado en un color semilla azul.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // Habilita el uso de Material 3.
        useMaterial3: true,
      ),
      // Define la pantalla principal que se mostrará al iniciar.
      home: const FormularioCorreoPage(),
    );
  }
}

// Define la pantalla principal como un StatefulWidget (puede cambiar su estado).
class FormularioCorreoPage extends StatefulWidget {
  // Constructor constante de la clase.
  const FormularioCorreoPage({super.key});

  // Método obligatorio que crea el estado asociado a este widget.
  @override
  State<FormularioCorreoPage> createState() => _FormularioCorreoPageState();
}

// Clase que maneja el estado de la pantalla.
class _FormularioCorreoPageState extends State<FormularioCorreoPage> {
  // Crea un controlador para leer y manipular el texto del TextField.
  final TextEditingController _ctrl = TextEditingController();

  // Variable de estado que guardará el correo ingresado para mostrarlo en pantalla.
  String _correoIngresado = '';

  // Método que se ejecuta cuando el usuario pulsa el botón "Enviar".
  void _enviarCorreo() {
    // Imprime en consola el texto actual del controlador (útil para depurar).
    print('--- Botón Enviar presionado ---');
    // Lee el texto del campo, eliminando espacios en blanco al inicio y final.
    String texto = _ctrl.text.trim();
    // Imprime el valor leído en la consola.
    print('Texto leído del campo: "$texto"');

    // Valida si el campo está vacío.
    if (texto.isEmpty) {
      // Imprime un mensaje de advertencia en la consola.
      print('Validación fallida: el campo está vacío.');
      // Muestra un SnackBar (mensaje flotante) para avisar al usuario.
      ScaffoldMessenger.of(context).showSnackBar(
        // Configura el contenido del SnackBar.
        const SnackBar(
          // Texto que verá el usuario.
          content: Text('Por favor, ingresa un correo electrónico.'),
          // Color de fondo del mensaje (rojo para error).
          backgroundColor: Colors.red,
        ),
      );
      // Sale del método para no actualizar la pantalla con datos vacíos.
      return;
    }

    // Imprime en consola que la validación fue exitosa.
    print('Validación exitosa. Actualizando pantalla con setState...');

    // Llama a setState para indicar a Flutter que el estado cambió y debe redibujar.
    setState(() {
      // Asigna el texto validado a la variable de estado.
      _correoIngresado = texto;
    });

    // Imprime en consola que la pantalla ha sido actualizada.
    print('Pantalla actualizada. Correo guardado: $_correoIngresado');
  }

  // Método que se ejecuta cuando el widget se destruye (limpieza).
  @override
  void dispose() {
    // Libera los recursos del controlador para evitar fugas de memoria.
    _ctrl.dispose();
    // Llama al dispose de la clase padre.
    super.dispose();
  }

  // Método que construye la interfaz visual.
  @override
  Widget build(BuildContext context) {
    // Retorna un Scaffold (estructura base de la pantalla).
    return Scaffold(
      // Crea la barra superior de la aplicación.
      appBar: AppBar(
        // Color de fondo de la barra (Azul).
        backgroundColor: Colors.blue,
        // Título que se mostrará en la barra.
        title: const Text(
          // Texto del título.
          'Formulario de correo',
          // Estilo del texto (blanco y en negrita).
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // Define el cuerpo de la pantalla.
      body: Padding(
        // Aplica un margen interno de 20 píxeles a todos los lados.
        padding: const EdgeInsets.all(20.0),
        // Retorna una columna para apilar los widgets verticalmente.
        child: Column(
          // Alinea los hijos al inicio del eje horizontal (izquierda).
          crossAxisAlignment: CrossAxisAlignment.start,
          // Lista de widgets que irán dentro de la columna.
          children: [
            // Widget de texto para la etiqueta.
            const Text(
              // Texto de la etiqueta.
              'Ingresa tu correo',
              // Estilo del texto (tamaño 18, negrita).
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Separador vertical de 10 píxeles (equivale al margin en Android).
            const SizedBox(height: 10),
            // Campo de texto para ingresar el correo.
            TextField(
              // Asigna el controlador para manejar el texto.
              controller: _ctrl,
              // Define el tipo de teclado (correo electrónico).
              keyboardType: TextInputType.emailAddress,
              // Decoración visual del campo (borde).
              decoration: const InputDecoration(
                // Texto de ayuda dentro del campo.
                hintText: 'estudiante@uae.edu.ec',
                // Borde por defecto (OutlineInputBorder).
                border: OutlineInputBorder(),
              ),
            ),
            // Separador vertical de 20 píxeles.
            const SizedBox(height: 20),
            // Botón elevado para enviar el correo.
            ElevatedButton(
              // Acción que se ejecuta al pulsar el botón.
              onPressed: _enviarCorreo,
              // Estilo del botón (color verde y expansión).
              style: ElevatedButton.styleFrom(
                // Color de fondo del botón (Verde).
                backgroundColor: Colors.green,
                // Color del texto del botón.
                foregroundColor: Colors.white,
                // Tamaño mínimo del botón (ancho infinito para ocupar todo el espacio).
                minimumSize: const Size(double.infinity, 50),
              ),
              // Texto que muestra el botón.
              child: const Text(
                // Contenido del texto.
                'Enviar',
                // Estilo del texto (tamaño 18, negrita).
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Separador vertical de 20 píxeles.
            const SizedBox(height: 20),
            // Widget de texto para mostrar el resultado (solo si hay correo).
            Text(
              // Muestra el texto concatenado o vacío si no hay nada.
              _correoIngresado.isNotEmpty
                  ? 'Correo ingresado: $_correoIngresado'
                  : '',
              // Estilo del texto (tamaño 18, azul oscuro, negrita).
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
