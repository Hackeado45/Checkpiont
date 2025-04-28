// Importamos las librerías necesarias
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/tarea.dart'; // Importamos el modelo Tarea

// Pantalla para editar una tarea existente
class EditTaskScreen extends StatefulWidget {
  final int index; // Índice de la tarea en la base de datos Hive
  final Tarea tarea; // Objeto Tarea que vamos a editar

  EditTaskScreen({required this.index, required this.tarea});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  // Controladores para capturar los textos modificados
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late DateTime _fechaLimite; // Variable para almacenar la fecha seleccionada

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los valores actuales de la tarea
    _tituloController = TextEditingController(text: widget.tarea.titulo);
    _descripcionController = TextEditingController(
      text: widget.tarea.descripcion,
    );
    _fechaLimite = widget.tarea.fechaLimite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Editar tarea',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Campo para editar el título
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Campo para editar la descripción
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Muestra la fecha actual y permite cambiarla
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Fecha límite: ${_fechaLimite.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                // Botón para seleccionar una nueva fecha con un DatePicker
                TextButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _fechaLimite,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _fechaLimite = picked;
                      });
                    }
                  },
                  child: Text('Cambiar Fecha'),
                ),
              ],
            ),

            Spacer(), // Empuja el botón hacia abajo
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Obtenemos la caja Hive y actualizamos la tarea
                  final box = Hive.box<Tarea>('tareas');
                  widget.tarea.titulo = _tituloController.text;
                  widget.tarea.descripcion = _descripcionController.text;
                  widget.tarea.fechaLimite = _fechaLimite;

                  // Guardamos los cambios
                  await widget.tarea.save();

                  // Cerramos la pantalla de edición
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1D9BF0),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Guardar cambios', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
