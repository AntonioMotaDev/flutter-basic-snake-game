import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class GameControls extends StatelessWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.arrowUp:
              context.read<GameState>().changeDirection(Direction.up);
              break;
            case LogicalKeyboardKey.arrowDown:
              context.read<GameState>().changeDirection(Direction.down);
              break;
            case LogicalKeyboardKey.arrowLeft:
              context.read<GameState>().changeDirection(Direction.left);
              break;
            case LogicalKeyboardKey.arrowRight:
              context.read<GameState>().changeDirection(Direction.right);
              break;
          }
        }
        return KeyEventResult.handled;
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 200,
        child: Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 50,
                  child: _ControlButton(
                    icon: Icons.arrow_upward,
                    onPressed: () {
                      context.read<GameState>().changeDirection(Direction.up);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 50,
                  child: _ControlButton(
                    icon: Icons.arrow_downward,
                    onPressed: () {
                      context.read<GameState>().changeDirection(Direction.down);
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 50,
                  child: _ControlButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      context.read<GameState>().changeDirection(Direction.left);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 50,
                  child: _ControlButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      context.read<GameState>().changeDirection(Direction.right);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Material(
        color: Colors.green.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 30,
          ),
        ),
      ),
    );
  }
} 