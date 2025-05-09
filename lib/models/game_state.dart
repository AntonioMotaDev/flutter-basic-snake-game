import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class HighScore {
  final String name;
  final int score;

  HighScore(this.name, this.score);

  @override
  String toString() => '$name: $score';
}

class GameState extends ChangeNotifier {
  static const int gridSize = 20;
  List<Position> snake = [Position(5, 5)];
  Position food = Position(10, 10);
  Direction direction = Direction.right;
  bool isGameOver = false;
  bool isPlaying = false;
  Timer? gameTimer;
  int score = 0;
  List<HighScore> highScores = [];
  static const String highScoresKey = 'highScores';

  GameState() {
    loadHighScores();
  }

  void startGame() {
    if (gameTimer != null) {
      gameTimer!.cancel();
    }
    snake = [Position(5, 5)];
    direction = Direction.right;
    isGameOver = false;
    isPlaying = true;
    score = 0;
    generateFood();
    gameTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      moveSnake();
    });
    notifyListeners();
  }

  void generateFood() {
    final random = Random();
    do {
      food = Position(
        random.nextInt(gridSize),
        random.nextInt(gridSize),
      );
    } while (snake.any((pos) => pos.x == food.x && pos.y == food.y));
    print('Generated food at: (${food.x}, ${food.y})');
    notifyListeners();
  }

  void moveSnake() {
    if (isGameOver) return;

    final head = snake.first;
    Position newHead;

    switch (direction) {
      case Direction.up:
        newHead = Position(head.x, (head.y - 1) % gridSize);
        break;
      case Direction.down:
        newHead = Position(head.x, (head.y + 1) % gridSize);
        break;
      case Direction.left:
        newHead = Position((head.x - 1) % gridSize, head.y);
        break;
      case Direction.right:
        newHead = Position((head.x + 1) % gridSize, head.y);
        break;
    }

    // Handle negative wraparound
    if (newHead.x < 0) newHead = Position(gridSize - 1, newHead.y);
    if (newHead.y < 0) newHead = Position(newHead.x, gridSize - 1);

    print('Snake head at: (${newHead.x}, ${newHead.y})');

    if (snake.any((pos) => pos.x == newHead.x && pos.y == newHead.y)) {
      print('Game over: Snake collision');
      gameOver();
      return;
    }

    snake.insert(0, newHead);

    if (newHead.x == food.x && newHead.y == food.y) {
      print('Food eaten! Score: $score');
      score += 10;
      generateFood();
    } else {
      snake.removeLast();
    }

    notifyListeners();
  }

  void changeDirection(Direction newDirection) {
    // Prevent 180-degree turns
    if ((direction == Direction.up && newDirection == Direction.down) ||
        (direction == Direction.down && newDirection == Direction.up) ||
        (direction == Direction.left && newDirection == Direction.right) ||
        (direction == Direction.right && newDirection == Direction.left)) {
      return;
    }
    print('Direction changed to: $newDirection');
    direction = newDirection;
  }

  void gameOver() {
    isGameOver = true;
    isPlaying = false;
    gameTimer?.cancel();
    print('Game Over! Final score: $score');
    notifyListeners();
  }

  Future<void> loadHighScores() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final scoresJson = prefs.getStringList(highScoresKey) ?? [];
      print('Loading high scores: $scoresJson');
      
      highScores = scoresJson.map((scoreStr) {
        final parts = scoreStr.split(':');
        if (parts.length == 2) {
          return HighScore(
            parts[0],
            int.parse(parts[1]),
          );
        }
        return null;
      }).whereType<HighScore>().toList();
      
      print('Loaded high scores: ${highScores.map((s) => '${s.name}: ${s.score}').join(', ')}');
      notifyListeners();
    } catch (e) {
      print('Error loading high scores: $e');
      highScores = [];
      notifyListeners();
    }
  }

  Future<void> saveHighScore(String playerName) async {
    try {
      final newScore = HighScore(playerName, score);
      highScores.add(newScore);
      highScores.sort((a, b) => b.score.compareTo(a.score));
      if (highScores.length > 5) {
        highScores = highScores.sublist(0, 5);
      }

      final prefs = await SharedPreferences.getInstance();
      final scoresJson = highScores
          .map((score) => '${score.name}:${score.score}')
          .toList();
      
      print('Saving high scores: $scoresJson');
      await prefs.setStringList(highScoresKey, scoresJson);
      notifyListeners();
    } catch (e) {
      print('Error saving high score: $e');
    }
  }
}

enum Direction { up, down, left, right } 