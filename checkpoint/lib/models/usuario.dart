import 'package:hive/hive.dart';

part 'usuario.g.dart';

@HiveType(typeId: 1)
class Usuario extends HiveObject {
  @HiveField(0)
  String nombre;

  @HiveField(1)
  String correo;

  @HiveField(2)
  String contrasena;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.contrasena,
  });
}
