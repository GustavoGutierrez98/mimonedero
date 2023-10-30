import 'package:flutter/material.dart';
import 'package:mimonedero/widgets/navbar.dart';

class Transaction {
  final DateTime date;
  final String description;
  final double monto;
  final bool IngrEgre; // Para distinguir entre ingresos (false) y egresos (true).
  final String idCliente;

  Transaction({
    required this.date,
    required this.description,
    required this.monto,
    required this.IngrEgre,
    required this.idCliente,
  });
}

class HistorialGeneral extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      date: DateTime(2023, 9, 15),
      description: "Descripción 1",
      monto: -20.0,
      IngrEgre: true, 
      idCliente: '',
    ),
    Transaction(
      date: DateTime(2023, 9, 14),
      description: "Descripción 2",
      monto: 30.0,
      IngrEgre: false, 
      idCliente: '',
    ),
    Transaction(
      date: DateTime(2023, 9, 13),
      description: "Descripción 3",
      monto: -15.0,
      IngrEgre: true,
      idCliente: '',
    ),
    Transaction(
      date: DateTime(2023, 9, 12),
      description: "Descripción 4",
      monto: 25.0,
      IngrEgre: false, 
      idCliente: '',
    ),
    // Agrega más transacciones aquí
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 66, 65, 65),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Historial de Transacciones"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Historial general de transacciones",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Gustavo Gutierrez",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "[Período de Tiempo]",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];
                  return Column(
                    children: [
                      if (index == 0 || transaction.date != transactions[index - 1].date)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          color: Colors.grey.shade200,
                          child: Text(
                            "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ListTile(
                        title: Text(transaction.description),
                        subtitle: Text(
                          "Monto: \$${transaction.monto.toStringAsFixed(2)}",
                        ),
                        trailing: Text(
                          transaction.IngrEgre ? "Egreso" : "Ingreso",
                          style: TextStyle(
                            color: transaction.IngrEgre ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
         bottomNavigationBar: NavBar(), // Integrar la barra de navegación NavBar
      ),
    );
  }
}