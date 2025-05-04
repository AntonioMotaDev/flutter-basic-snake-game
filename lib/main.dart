import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/game_screen.dart';
import 'models/game_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        title: 'Snake Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: const GameScreen(),
      ),
    );
  }
} 