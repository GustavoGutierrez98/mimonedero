import 'package:flutter/material.dart';
import 'package:mimonedero/database/db.dart';
import 'package:mimonedero/models/details.dart';
import 'package:mimonedero/models/ingreso.dart';
import 'package:mimonedero/models/pagos.dart';

class BalanceView extends StatefulWidget {
  final List<Balance> balances;
  BalanceView({required this.balances, required double currentBalance});
  @override
  _BalanceViewState createState() => _BalanceViewState();
 

}
class _BalanceViewState extends State<BalanceView> {
  late List<Balance> _balances;
  late List<Payment> _payments;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final deposits = await BalanceDatabase.instance.getAllBalances();
    final payments = await PaymentDatabase.instance.getAllPayments();

    setState(() {
      _balances = deposits;
      _payments = payments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Saldo y Pagos'),
      ),
      body: ListView.builder(
  itemCount: _balances.length + _payments.length,
  itemBuilder: (context, index) {
    if (index < _balances.length) {
      final balance = _balances[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDetailScreen(balance),
            ),
          );
        },
        child: ListTile(
          title: Text('Saldo: \$${balance.amount.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green)),
        ),
      );
    } else {
      final payment = _payments[index - _balances.length];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDetailScreen(payment),
            ),
          );
        },
        child: ListTile(
          title: Text('Pago: -\$${payment.amount.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.red)),
        ),
      );
    }
  },
),

    );
  }
}