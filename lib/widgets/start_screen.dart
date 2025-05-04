import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Snake Game',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              context.read<GameState>().startGame();
            },
            child: const Text('Start Game'),
          ),
          const SizedBox(height: 40),
          const Text(
            'High Scores:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Consumer<GameState>(
            builder: (context, gameState, child) {
              return Column(
                children: gameState.highScores.map((score) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '${score.name}: ${score.score}',
                    style: const TextStyle(fontSize: 18),
                  ),
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
} 