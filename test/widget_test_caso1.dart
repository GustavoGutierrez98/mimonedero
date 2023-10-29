//clase de origen: ingreso.dart
// prueba comprobando el comportamiento del saldo y la funcionalidad de depósito de dinero.
//
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimonedero/models/ingreso.dart'; // Asegúrate de importar tu vista de MiCartera

void main() {
  testWidgets('Prueba de la vista de MiCartera', (WidgetTester tester) async {
    // Construir el widget
    await tester.pumpWidget(MaterialApp(
      home: IngresoDinero(),
    ));

    // Esperar a que se actualice la vista
    await tester.pump();

    // Verificar que se muestre el saldo inicial
    expect(find.text('Saldo Actual:'), findsOneWidget);
    expect(find.text('\$0.00'), findsOneWidget); // Puedes ajustar el saldo inicial según tus necesidades

    // Realizar una simulación de depósito
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump();

    // Verificar que se muestre el cuadro de diálogo de depósito
    expect(find.text('Depositar Dinero'), findsOneWidget);

    // Simular un depósito de $100.00
    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.text('Depositar'));
    await tester.pump();

    // Verificar que el saldo se actualice después del depósito
    expect(find.text('\$100.00'), findsOneWidget);

  });
}
