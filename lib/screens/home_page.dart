import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/character_list_page.dart';
import 'package:rickandmorty/screens/episods_list_page.dart';
import 'package:rickandmorty/screens/locations_list_page.dart';
import 'package:rickandmorty/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CharacterListPage(),
    LocationListPage(),
    EpisodsListPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(21, 42, 58, 1),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromRGBO(67, 208, 73, 1),
        unselectedItemColor: Color.fromRGBO(91, 105, 117, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/characterIcon.png')),
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/locationIcon.png')),
            label: 'Локации',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/episodeIcon.png')),
            label: 'Эпизоды',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/settingsIcon.png')),
            label: 'Настройки',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
