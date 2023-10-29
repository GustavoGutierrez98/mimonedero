//ejemplo sacado de la clase: balance_view.dart
//En esta prueba, nos centraremos en verificar que la vista muestre correctamente 
//los elementos cuando se cargan datos de saldos.

//***por alguna razon me sale error ***
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mimonedero/models/balance_view.dart'; // Asegúrate de importar tu vista de BalanceView

// void main() {
//   testWidgets('Prueba de la vista de BalanceView con datos de saldos', (WidgetTester tester) async {
//     // Simular una lista de datos de saldos
//     final fakeBalances = [
//       Balance(amount: 100.0, date: '2023-10-28'),
//       Balance(amount: 200.0, date: '2023-10-29'),
//     ];

//     // Construir el widget BalanceView con datos de saldos simulados
//     await tester.pumpWidget(MaterialApp(
//       home: BalanceView(),
//     ));

//     // Simular la carga de datos de saldos en la vista
//     BalanceDatabase.instance = FakeBalanceDatabase(fakeBalances);
//     await tester.pump();

//     // Verificar que se muestre el título de la AppBar
//     expect(find.text('Saldo Guardado'), findsOneWidget);

//     // Verificar que se muestren elementos en la lista de saldos
//     expect(find.text('Amount: 100.0'), findsOneWidget);
//     expect(find.text('Date: 2023-10-28'), findsOneWidget);
//     expect(find.text('Amount: 200.0'), findsOneWidget);
//     expect(find.text('Date: 2023-10-29'), findsOneWidget);

//     // Puedes agregar más verificaciones según tus necesidades
//   });
// }

// // Clase falsa para simular la base de datos (puedes ajustarla según tus necesidades)
// class FakeBalanceDatabase extends BalanceDatabase {
//   List<Balance> fakeBalances;

//   FakeBalanceDatabase(this.fakeBalances);

//   @override
//   Future<List<Balance>> getAllBalances() async {
//     return fakeBalances;
//   }
// }
