import 'package:flutter/material.dart';

import 'form/form_screen.dart';
import 'home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Slideworks',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/form': (context) => FormScreen()
      },
    );
  }
}
