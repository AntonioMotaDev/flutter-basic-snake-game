import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: GameState.gridSize,
                ),
                itemCount: GameState.gridSize * GameState.gridSize,
                itemBuilder: (context, index) {
                  final x = index % GameState.gridSize;
                  final y = index ~/ GameState.gridSize;
                  final position = Position(x, y);

                  final isFood = gameState.food.x == x && gameState.food.y == y;
                  final isSnake = gameState.snake.any((pos) => pos.x == x && pos.y == y);

                  if (isSnake) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  } else if (isFood) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
} 