//clase de origen: balance_view.dart
// En esta prueba, nos centraremos en verificar el comportamiento cuando la lista de saldos está vacía:

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimonedero/models/balance_view.dart'; // Asegúrate de importar tu vista de Balance

void main() {
  testWidgets('Prueba de la vista de saldo cuando la lista está vacía', (WidgetTester tester) async {
    // Construir el widget
    await tester.pumpWidget(MaterialApp(
      home: BalanceView(),
    ));

    // Esperar a que se actualice la vista
    await tester.pump();

    // Verificar que se muestre el título de la AppBar
    expect(find.text('Saldo Guardado'), findsOneWidget);

    // Verificar que no se encuentran elementos en la lista de saldos
    expect(find.byType(ListTile), findsNothing);

    // Puedes agregar más verificaciones según tus necesidades
  });
}
