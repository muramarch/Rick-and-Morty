import 'package:flutter/material.dart';

class EpisodsListPage extends StatefulWidget {
  const EpisodsListPage({super.key});

  @override
  State<EpisodsListPage> createState() => _EpisodsListPageState();
}

class _EpisodsListPageState extends State<EpisodsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Episods')),
    );
  }
}
