// Importamos los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/tarea.dart';
import 'edit_task_screen.dart';

// Creamos la pantalla principal (Inicio) como un widget sin estado
class HomeScreen extends StatelessWidget {
  // Accedemos a la caja de Hive donde están guardadas las tareas
  final Box<Tarea> tareaBox = Hive.box<Tarea>('tareas');

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1), // Color de fondo general
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Mis Tareas',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),

      // Este widget escucha los cambios en la caja y actualiza la vista automáticamente
      body: ValueListenableBuilder(
        valueListenable: tareaBox.listenable(),
        builder: (context, Box<Tarea> box, _) {
          // Si no hay tareas, mostramos un texto amigable
          if (box.values.isEmpty) {
            return Center(
              child: Text(
                'No hay tareas aún.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          // Si hay tareas, las mostramos en una lista
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final tarea = box.getAt(index);

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),

                  // Título de la tarea
                  title: Text(
                    tarea!.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF0A0E21),
                    ),
                  ),

                  // Subtítulo con descripción y fecha
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      Text(
                        tarea.descripcion,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Límite: ${tarea.fechaLimite.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  // Casilla para marcar como completada
                  trailing: Checkbox(
                    value: tarea.completada,
                    onChanged: (value) {
                      tarea.completada = value!;
                      tarea.save(); // Guardamos el cambio
                    },
                  ),

                  // Al tocar la tarea, abrimos la pantalla de edición
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                EditTaskScreen(index: index, tarea: tarea),
                      ),
                    );
                  },

                  // Al mantener presionado, mostramos un diálogo para eliminar
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text('¿Eliminar tarea?'),
                            content: Text(
                              '¿Estás seguro de que quieres borrar esta tarea?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  box.deleteAt(index); // Eliminar tarea
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      // Botón flotante para añadir nueva tarea
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1D9BF0),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
