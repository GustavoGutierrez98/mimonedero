import 'package:flutter/material.dart';
import 'package:mimonedero/models/historial.dart';
import 'package:mimonedero/models/pantalla_principal.dart';
import 'package:mimonedero/models/ingreso.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation as before
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => IngresoDinero()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HistorialGeneral()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Depositar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Historial',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.black, // Color of unselected items
      backgroundColor: Colors.deepOrange, // Background color of the navigation bar
      onTap: _onItemTapped,
    );
  }
}
