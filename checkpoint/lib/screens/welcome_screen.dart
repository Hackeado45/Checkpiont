import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono decorativo
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Color(0xFF1D9BF0),
              ),
              SizedBox(height: 30), // Espacio entre el icono y el título
              // Título de bienvenida
              Text(
                '¡Bienvenido a Checkpoint!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A0E21),
                ),
              ),
              SizedBox(height: 20),

              // Subtítulo de la app
              Text(
                'Tu gestor de tareas sencillo y eficaz.',
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40), // Espacio antes de los botones
              // Botón de Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio lógico entre los botones
              // Botón de Register
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio lógico entre los botones
              // Botón para ingresar como invitado
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'ENTRAR COMO INVITADO',
                    style: TextStyle(letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
