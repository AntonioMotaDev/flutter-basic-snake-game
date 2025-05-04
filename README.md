# Flutter Snake Game

A classic Snake game built with Flutter, featuring a responsive design that works on both desktop and mobile devices.

## Features

- 🎮 Classic snake gameplay
- 📱 Responsive design (works on both mobile and desktop)
- 🏆 Top 5 high scores with player names
- ⌨️ Keyboard controls for desktop
- 📱 Touch controls for mobile
- 🎯 Score tracking
- 🌗 Dark theme


## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository:
   ```bash
   git clone [your-repository-url]
   cd snake
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the game:
   ```bash
   flutter run
   ```

## How to Play

1. **Starting the Game**
   - Click the "Start Game" button on the home screen
   - Use arrow keys (desktop) or on-screen controls (mobile) to control the snake

2. **Controls**
   - **Desktop**: Arrow keys (↑, ↓, ←, →)
   - **Mobile**: Touch the on-screen arrow buttons
   - **Restart**: Click the refresh button in the app bar during gameplay

3. **Gameplay**
   - Guide the snake to eat the red food squares
   - Each food eaten increases your score by 10 points
   - The snake grows longer with each food eaten
   - Game ends if the snake hits itself
   - When game ends, enter your name to save your score
   - Top 5 high scores are saved and displayed

## Game Features

### High Score System
- Stores the top 5 highest scores
- Each score entry includes player name and score
- Scores persist between game sessions
- Automatically updates when new high scores are achieved

### Responsive Design
- Adapts to both portrait and landscape orientations
- Optimized for both desktop and mobile screens
- Maintains aspect ratio for consistent gameplay

## Development

This game is built using:
- Flutter for cross-platform development
- Provider for state management
- SharedPreferences for score persistence

## Contributing

Feel free to contribute to this project by:
1. Forking the repository
2. Creating a feature branch
3. Committing your changes
4. Opening a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by the classic Snake game
- Built with Flutter and Dart
