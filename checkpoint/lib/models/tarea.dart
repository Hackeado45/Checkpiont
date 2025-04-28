// Importamos Hive, que es la base de datos local que usamos
import 'package:hive/hive.dart';

// Parte generada automáticamente por Hive (es necesaria para la serialización)
part 'tarea.g.dart';

// Indicamos que esta clase es un tipo Hive y le asignamos un ID único (0)
@HiveType(typeId: 0)
class Tarea extends HiveObject {
  // Cada campo necesita un identificador único (igual que un índice)

  // Campo para el título de la tarea
  @HiveField(0)
  String titulo;

  // Campo para la descripción de la tarea
  @HiveField(1)
  String descripcion;

  // Campo para la fecha límite de la tarea
  @HiveField(2)
  DateTime fechaLimite;

  // Campo para saber si la tarea ya se completó o no
  @HiveField(3)
  bool completada;

  // Constructor de la clase Tarea
  Tarea({
    required this.titulo,
    required this.descripcion,
    required this.fechaLimite,
    this.completada = false, // Por defecto, la tarea no está completada
  });
}
