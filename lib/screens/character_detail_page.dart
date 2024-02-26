import 'package:flutter/material.dart';

class CharacterDetail extends StatelessWidget {
  final Map<String, dynamic> character;

  const CharacterDetail({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 30, 45, 1),
    );
  }
}
