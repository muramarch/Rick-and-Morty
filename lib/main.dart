import 'package:flutter/material.dart';

import 'package:rickandmorty/screens/home_page.dart';
import 'package:rickandmorty/screens/start_page.dart';

void main() {
  runApp(RickAndMorty());
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
      routes: {
        '/home_page': (context) => HomePage(),
      },
    );
  }
}
