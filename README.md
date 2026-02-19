# Eternal Grind

A semester-long discipline and habit-tracking Flutter application with cultivation-novel aesthetics.

## Overview

Eternal Grind is a harsh, no-nonsense habit tracker that enforces discipline through consequences. The app features:

- **Streak System**: Track consecutive days of task completion
- **Cursed Marks**: Punishment for breaking streaks
- **Relief Days**: Earned mercy at milestones
- **Recovery Mode**: Path to redemption after failure
- **Account Deletion**: Ultimate consequence at 10 cursed marks

## Features

### Core Mechanics

1. **Daily Tasks**
   - Define 2+ tasks on Day 1
   - Tasks are locked after Day 1 for the semester
   - Must complete ALL tasks daily to maintain streak

2. **Streak Tracking**
   - Increments by +1 for each successful day
   - Breaks on missed days (unless relief day available)
   - Milestones at 10, 20, 50, 100, 150 days

3. **Relief Days**
   - Earned at 50, 100, and 150-day milestones
   - Automatically consumed when a day is missed
   - Prevents streak break and curse application

4. **Cursed Marks**
   - Applied when streak breaks without relief day
   - Requires recovery: cursed_marks × 10 consecutive days
   - Account permanently deleted at 10 cursed marks

5. **Recovery Mode**
   - Activated after receiving cursed mark
   - Normal streak doesn't increase during recovery
   - Curse removed after completing recovery requirement

### UI/UX

- **Dark Theme**: Black, charcoal, deep red, muted gold
- **Typography**: Cinzel (serif) for headings, Roboto Mono for body
- **Animations**: Subtle pulses, fades, and transitions
- **Cursed Visual Effects**: Darkened overlay with pulsing red glow

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
│   ├── task.dart
│   ├── streak_data.dart
│   ├── cursed_mark.dart
│   ├── relief_day.dart
│   └── user_profile.dart
├── services/                    # Business logic
│   ├── storage_service.dart     # Hive persistence
│   ├── task_service.dart        # Task management
│   ├── streak_service.dart      # Streak logic
│   ├── curse_service.dart       # Curse/relief logic
│   └── validation_service.dart  # Anti-cheat
├── providers/                   # State management
│   └── app_state_provider.dart
├── screens/                     # UI screens
│   ├── day_one_setup_screen.dart
│   ├── dashboard_screen.dart
│   ├── task_manager_screen.dart
│   └── profile_screen.dart
├── widgets/                     # Reusable components
│   ├── streak_counter.dart
│   ├── curse_warning_modal.dart
│   ├── milestone_message.dart
│   ├── cursed_overlay.dart
│   └── task_card.dart
└── theme/                       # Styling
    ├── app_theme.dart
    ├── colors.dart
    └── text_styles.dart
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android device or emulator

### Installation

1. **Clone or navigate to the project**
   ```bash
   cd eternal_grind
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

   Or for specific platforms:
   ```bash
   flutter run -d windows    # Windows
   flutter run -d android    # Android
   flutter run -d chrome     # Web (for testing)
   ```

## Usage Guide

### Day 1 Setup

1. Launch the app for the first time
2. Read the introduction message
3. Add at least 2 daily tasks
4. Tasks can be added/removed freely on Day 1 only
5. Click "BEGIN THE GRIND" to start

### Daily Routine

1. Open the app to see your current streak
2. Navigate to "VIEW TASKS"
3. Complete all tasks by checking them off
4. Streak increments automatically when all tasks are done

### Milestone Achievements

- **10 days**: First milestone message
- **20 days**: Second milestone message
- **50 days**: Milestone message + 1 Relief Day
- **100 days**: Milestone message + 1 Relief Day
- **150 days**: Milestone message + 1 Relief Day

### Handling Failure

- **With Relief Day**: Automatically consumed, streak continues
- **Without Relief Day**: Cursed mark applied, streak breaks
- **Recovery**: Complete (cursed_marks × 10) consecutive days
- **At 10 Cursed Marks**: Account permanently deleted

## Technical Details

### Data Persistence

- **Storage**: Hive (offline-first, local storage)
- **Format**: JSON serialization
- **Boxes**: `user_profile`, `tasks`

### Anti-Cheat Mechanisms

- Date-based validation
- Time rollback detection
- Day transition verification
- Prevents duplicate day completions

### State Management

- **Provider**: For app-wide state
- **AppStateProvider**: Manages profile, tasks, and game logic

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  provider: ^6.1.1
  intl: ^0.18.1
  google_fonts: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  hive_generator: ^2.0.1
  build_runner: ^2.4.6
```

## Future Enhancements

1. **Cultivation Ranks**: Unlock titles based on highest streak
2. **Silent Mode**: Option to disable milestone messages
3. **Broken Streak Archive**: Historical view of past streaks
4. **Semester Summary**: End-of-semester achievement report
5. **Custom Milestones**: User-defined milestone goals
6. **Export Statistics**: Shareable summary cards
7. **Home Screen Widget**: Display current streak
8. **Daily Reminders**: Optional notifications (non-intrusive)

## Philosophy

Eternal Grind embraces harsh truth over comfortable lies:

- No gamification gimmicks
- Real consequences for failure
- Earned progress through consistent effort
- Recovery through discipline, not shortcuts

*"Discipline is not loud. It is quiet and consistent."*

## License

This project is created for educational purposes.

## Support

For issues or questions, please refer to the implementation plan and code documentation.
