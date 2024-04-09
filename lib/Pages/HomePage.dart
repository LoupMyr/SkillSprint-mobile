import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Layouts/Accueil.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';
import 'package:skillsprint/Layouts/CreateProgrammes.dart';
import 'package:skillsprint/Layouts/Profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.authService});
  final AuthServiceInterface authService;
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    CreateProgrammes(),
    Accueil(),
    Profil()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLayout(title: "Accueil", authService: widget.authService),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Créer ton programme',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profil',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
