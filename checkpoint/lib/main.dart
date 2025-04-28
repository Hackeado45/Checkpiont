// Importamos los paquetes necesarios para Flutter y Hive (la base de datos local)
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Importamos nuestros modelos y pantallas personalizadas
import 'models/tarea.dart';
import 'models/usuario.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';

// Función principal que se ejecuta al iniciar la app
void main() async {
  // Nos aseguramos de que Flutter esté completamente inicializado antes de ejecutar tareas asincrónicas
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializamos Hive para poder usarlo como base de datos local
  await Hive.initFlutter();

  // Registramos el adaptador de nuestro modelo Tarea, para que Hive entienda cómo guardar y leer objetos Tarea
  Hive.registerAdapter(TareaAdapter());

  // Abrimos o creamos una "box" llamada 'tareas', que funciona como una tabla donde se almacenan nuestras tareas
  await Hive.openBox<Tarea>('tareas');

  // Lanzamos la aplicación principal
  runApp(MyApp());
}

// Widget principal de la aplicación
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkpoint', // Nombre de la app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // Tema general de la app (colores, fuentes, etc.)
      // Definimos la ruta que se abre al iniciar la app, en este caso la pantalla de bienvenida
      initialRoute: '/',

      // Mapeamos las rutas con las pantallas correspondientes
      routes: {
        '/': (context) => WelcomeScreen(), // Pantalla de bienvenida
        '/login': (context) => LoginScreen(), // Pantalla de login
        '/register': (context) => RegisterScreen(), // Pantalla de registro
        '/home':
            (context) =>
                HomeScreen(), // Pantalla principal con la lista de tareas
        '/add':
            (context) => AddTaskScreen(), // Pantalla para agregar nuevas tareas
      },
    );
  }
}
