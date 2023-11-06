import 'package:flutter/material.dart';
import 'package:mimonedero/database/db.dart';
import 'package:mimonedero/widgets/navbar.dart'; // Import the database class
import 'package:mimonedero/widgets/filtro_numerico.dart';

class VentanaPago extends StatefulWidget {
  @override
  _VentanaPagoState createState() => _VentanaPagoState();
}

class Payment {
  final int? id;
  final double amount;
  final String date;

  Payment({
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

class _VentanaPagoState extends State<VentanaPago> {
  double paymentAmount = 0.0; // Track the payment amount entered by the user
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Realizar Pago'),
      ),
       bottomNavigationBar: NavBar(),
       backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ingrese el monto del pago:',
              style: TextStyle(fontSize: 20,color: Colors.black),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                inputFormatters: [MyFilter()],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  paymentAmount = double.tryParse(value) ?? 0.0;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (paymentAmount > 0) {
                  makePayment(paymentAmount);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pago realizado con éxito.'),
                    ),
                  );
                  Navigator.pop(context); // Return to the previous screen after payment
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ingrese un monto válido.'),
                    ),
                  );
                }
              },
              child: Text('Confirmar Pago'),
              style: ElevatedButton.styleFrom(
    primary: Colors.deepOrange,
  ),
            ),
          ],
        ),
      ),
    );
  }

  void makePayment(double amount) async {
    // Create a Payment object
    final newPayment = Payment(amount: amount, date: DateTime.now().toString());
    // Insert the payment into the database
    final insertedId = await PaymentDatabase.instance.insertPayment(newPayment);
    if (insertedId != null) {
    } else {
      // Handle the case where payment insertion failed
    }
  }
}