import 'package:flutter/material.dart';

class Transaction {
  final String category;
  final DateTime date;
  final String description;
  final double amount;

  Transaction({
    required this.category,
    required this.date,
    required this.description,
    required this.amount,
  });
}

class PantallaMonedero extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      category: "Categoría 1",
      date: DateTime(2023, 9, 15),
      description: "Descripción 1",
      amount: -20.0,
    ),
    Transaction(
      category: "Categoría 1",
      date: DateTime(2023, 9, 14),
      description: "Descripción 2",
      amount: 30.0,
    ),
    Transaction(
      category: "Categoría 2",
      date: DateTime(2023, 9, 13),
      description: "Descripción 3",
      amount: -15.0,
    ),
    Transaction(
      category: "Categoría 2",
      date: DateTime(2023, 9, 12),
      description: "Descripción 4",
      amount: 25.0,
    ),
    // Agrega más transacciones aquí
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Historial de Transacciones"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Historial de Transacciones",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "[Nombre del Usuario]",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "[Período de Tiempo]",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
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
                      if (index == 0 || transaction.category != transactions[index - 1].category)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          color: Colors.grey.shade200,
                          child: Text(
                            transaction.category,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ListTile(
                        title: Text(transaction.description),
                        subtitle: Text(
                          "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                        ),
                        trailing: Text(
                          "\$${transaction.amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: transaction.amount < 0 ? Colors.red : Colors.green,
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
      ),
    );
  }
}