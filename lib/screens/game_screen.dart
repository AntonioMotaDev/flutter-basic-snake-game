import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../widgets/game_board.dart';
import '../widgets/score_board.dart';
import '../widgets/game_controls.dart';
import '../widgets/start_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
        actions: [
          Consumer<GameState>(
            builder: (context, gameState, child) {
              if (gameState.isPlaying) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    gameState.startGame();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          if (!gameState.isPlaying) {
            return const StartScreen();
          }
          
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? Column(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: GameBoard(),
                        ),
                        const Expanded(
                          child: Column(
                            children: [
                              ScoreBoard(),
                              GameControls(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: GameBoard(),
                        ),
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ScoreBoard(),
                              GameControls(),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          );
        },
      ),
    );
  }
} 