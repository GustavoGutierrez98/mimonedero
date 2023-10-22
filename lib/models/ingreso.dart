import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimonedero/models/filtro_numerico.dart';
import 'balance_view.dart';

class IngresoDinero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Monedero Virtual',
      home: MiCartera(),
    );
  }
}

class Balance {
  final int? id;
  final double amount;
  final String date;

  Balance({
    this.id,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date,
    };
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
                        inputFormatters: [MyFilter()],
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
            //Aquí sí funciona, lmao. El widtet de alineación no funciona porque está dentro de una columna, no al final del Scaffold
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.lock_open, size: 32),
                label: const Text(
                  'Salir',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
            ),
          ],
        ),
      ),
      //Antes que termine el Scaffold, irá el botón de salida
    );
  }
}
