import 'package:flutter/material.dart';
import 'package:mimonedero/database/db.dart';
import 'package:mimonedero/models/ingreso.dart';

class BalanceView extends StatefulWidget {
  @override
  _BalanceViewState createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  List<Balance> _balances = [];

  @override
  void initState() {
    super.initState();
    _loadBalances();
  }

  Future<void> _loadBalances() async {
    final balances = await BalanceDatabase.instance.getAllBalances();
    setState(() {
      _balances = balances;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saldo Guardado'),
      ),
      body: ListView.builder(
        itemCount: _balances.length,
        itemBuilder: (context, index) {
          final balance = _balances[index];
          return ListTile(
            title: Text('Amount: ${balance.amount}'),
            subtitle: Text('Date: ${balance.date}'),
          );
        },
      ),
    );
  }
}