import 'package:flutter/material.dart';
import 'package:mimonedero/models/pantalla_principal.dart';
import 'package:mimonedero/models/ingreso.dart';
import 'package:mimonedero/models/perfil.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(
    int index,
    /*String tabItem*/
  ) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Si se selecciona el botón "home", navega a la página Ingreso
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (index == 1) {
        // Si se selecciona el botón "balance", navega a la página Configuracion
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IngresoDinero()));
      } else if (index == 2) {
        // Si se selecciona el botón "balance", navega a la página Configuracion
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Perfil()));
      }
    });
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
          label: 'Transacciones',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
