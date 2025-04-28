// Importamos las librerías necesarias para la interfaz y el manejo de datos
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/tarea.dart'; // Importamos nuestro modelo de Tarea

// Pantalla para agregar una nueva tarea
class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Controladores para capturar lo que el usuario escribe en los campos de texto
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1), // Color de fondo claro
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2, // Sombra debajo de la AppBar
        centerTitle: true, // Centra el título
        title: Text(
          'Agregar tarea',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ), // Color del ícono de retroceso
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Espacio alrededor del contenido
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Campo para escribir el título de la tarea
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio entre campos
              // Campo para escribir la descripción
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Campo para ingresar la fecha límite de la tarea
              TextField(
                controller: fechaController,
                decoration: InputDecoration(
                  labelText: 'Fecha Límite (YYYY-MM-DD)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Botón para guardar la tarea
              SizedBox(
                width: double.infinity, // El botón ocupa todo el ancho
                child: ElevatedButton(
                  onPressed: () {
                    // Creamos un nuevo objeto de tipo Tarea con los datos ingresados
                    final newTarea = Tarea(
                      titulo: tituloController.text,
                      descripcion: descripcionController.text,
                      fechaLimite: DateTime.parse(fechaController.text),
                      completada: false, // La tarea se crea como no completada
                    );

                    // Abrimos la caja (base de datos local) y guardamos la tarea
                    final tareaBox = Hive.box<Tarea>('tareas');
                    tareaBox.add(newTarea);

                    // Cerramos la pantalla y volvemos atrás
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D9BF0), // Color del botón
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Agregar tarea', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
