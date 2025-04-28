import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:checkpoint/main.dart'; // Asegúrate de importar correctamente 'main.dart'

void main() async {
  // Inicializa Hive antes de ejecutar cualquier prueba
  TestWidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tareas'); // Abre las cajas necesarias

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construye nuestra app sin el `const` en el widget `MyApp`.
    await tester.pumpWidget(
      MyApp(),
    ); // Aquí debería estar `MyApp` sin el `const`

    // Verifica que nuestro contador empiece en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toca el ícono '+' y dispara el frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que nuestro contador haya incrementado.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
