import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Score: ${gameState.score}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              if (gameState.isGameOver) ...[
                const Text('Game Over!'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _showNameDialog(context),
                  child: const Text('Save Score'),
                ),
              ],
              const SizedBox(height: 16),
              const Text('High Scores:'),
              const SizedBox(height: 8),
              ...gameState.highScores.map((score) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${score.name}: ${score.score}'),
                  )),
            ],
          ),
        );
      },
    );
  }

  void _showNameDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Enter Your Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter your name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<GameState>().saveHighScore(controller.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
} 