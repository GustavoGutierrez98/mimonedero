import 'package:flutter/material.dart';

class IngresoDinero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Monedero Virtual',
      home: MiCartera(),
    );
  }
}

class MiCartera extends StatefulWidget {
  @override
  _MiCarteraState createState() => _MiCarteraState();
}

class _MiCarteraState extends State<MiCartera> {
  double balance = 0.0; // El saldo inicial

  // Función para agregar dinero al monedero
  void depositMoney(double amount) {
    setState(() {
      balance += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Monedero Virtual'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Saldo Actual:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // cuadro de diálogo para ingresar la cantidad a depositar
                // Luego, llama a la función depositMoney para actualizar el saldo.
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double amount = 0.0;
                    return AlertDialog(
                      title: Text('Depositar Dinero'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          amount = double.tryParse(value) ?? 0.0;
                        },
                      ),
                      actions: <Widget>[
                        // Boton cancelar ventana emergente
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          // Boton para depositar ingreso
                          child: Text('Depositar'),
                          onPressed: () {
                            depositMoney(amount);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Depositar Dinero'),
            ),
          ],
        ),
      ),
    );
  }
}