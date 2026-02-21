# Eternal Grind

A semester-long discipline and habit-tracking Flutter application with calendar integration and recurring task management.

## Overview

Eternal Grind is a comprehensive task management system that enforces discipline through consequences while providing flexible scheduling options. The app features:

- **Task Duration System**: Once, daily, weekly, and custom recurring tasks
- **Calendar Integration**: Visual calendar with task indicators and date-based filtering
- **Smart Recurring Logic**: Automatic task generation based on duration settings
- **Streak System**: Track consecutive days of task completion
- **Firebase Integration**: Real-time data sync across devices
- **Modern UI**: Dark theme with responsive design

## Features

### Task Management

1. **Duration Options**
   - **Once**: Single occurrence tasks on specific dates
   - **Daily**: Repeats every day from creation date
   - **Weekly**: Repeats on same weekday each week
   - **Custom**: Daily tasks within specified date range

2. **Calendar Integration**
   - Monthly calendar view with task indicators
   - Color-coded duration types (blue, green, orange, purple)
   - Date-based task filtering
   - Bidirectional navigation between calendar and home screen

3. **Smart Task Display**
   - Tasks automatically appear on correct dates
   - Recurring tasks show across all applicable dates
   - End date support for custom duration tasks
   - Visual duration indicators and labels

### User Experience

- **Date Navigation**: Previous/next day arrows and date picker
- **Quick Access**: Calendar month icon for full calendar view
- **Real-time Updates**: Instant task creation and modification
- **Responsive Design**: Works across web, mobile, and desktop

## Technical Architecture

### Core Components

```dart
lib/
├── models/
│   ├── task_model.dart          # Firestore task model
│   └── task_duration.dart      # Duration enum
├── services/
│   └── firestore_service.dart   # Firebase operations
├── screens/
│   ├── home_screen.dart         # Main task interface
│   └── calendar_screen.dart    # Calendar view
├── widgets/
│   └── add_task_dialog.dart    # Task creation interface
└── providers/
    ├── auth_provider.dart       # Authentication
    └── theme_provider.dart     # Theme management
```

### Data Flow

1. **Task Creation**: Dialog → Firestore → Real-time sync
2. **Calendar Updates**: Firestore → Stream → UI refresh
3. **Date Filtering**: Client-side recurring task logic
4. **Cross-device Sync**: Firebase real-time listeners

### Duration Logic

- **Daily Tasks**: Show every day after creation date
- **Weekly Tasks**: Show on same weekday as creation date
- **Custom Tasks**: Show daily within specified date range
- **Once Tasks**: Show only on creation date

## Setup & Installation

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Firebase project configuration
- Google Fonts package
- Provider for state management

### Quick Start

1. **Clone repository**
   ```bash
   git clone https://github.com/Soham-Patel1604/Eternal_Grind.git
   cd Eternal_Grind
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add `google-services.json` (Android)
   - Add `GoogleService-Info.plist` (iOS)
   - Configure web app in Firebase console

4. **Run application**
   ```bash
   flutter run -d chrome      # Web
   flutter run -d windows     # Windows
   flutter run -d android     # Android
   ```

## Usage Guide

### Creating Tasks

1. **Add Task**: Click floating action button
2. **Enter Details**: Title, description (optional)
3. **Select Duration**: Choose once, daily, weekly, or custom
4. **Set End Date**: Required for custom duration
5. **Save**: Task appears immediately on selected date

### Calendar Navigation

1. **Date Selection**: Tap any date in calendar
2. **Home Screen**: Shows tasks for selected date
3. **Quick Navigation**: Use arrow buttons or date picker
4. **Calendar Access**: Month icon opens full calendar view

### Task Management

- **Complete**: Check off tasks to mark as done
- **Delete**: Remove tasks (permanent action)
- **View**: See all tasks for any selected date
- **Filter**: Automatic date-based filtering

## Visual Features

### Duration Color Coding

- 🔵 **Blue**: Once tasks
- 🟢 **Green**: Daily tasks  
- 🟠 **Orange**: Weekly tasks
- 🟣 **Purple**: Custom tasks

### Calendar Indicators

- **Task Count**: Number badge on calendar dates
- **Duration Labels**: Small badges showing task type
- **End Dates**: Displayed for recurring tasks
- **Selection Highlight**: Visual feedback for selected date

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.15.2
  firebase_auth: ^5.7.0
  cloud_firestore: ^5.6.12
  provider: ^6.1.1
  google_fonts: ^6.3.3
  intl: ^0.18.1
  shared_preferences: ^2.2.2
```

## Recent Updates

### Version 2.0 - Calendar Integration

- ✅ Added task duration system (once, daily, weekly, custom)
- ✅ Implemented calendar screen with monthly view
- ✅ Added recurring task logic and date-based filtering
- ✅ Enhanced add task dialog with duration selection
- ✅ Fixed compilation errors and type mismatches
- ✅ Added color-coded duration indicators
- ✅ Implemented bidirectional navigation

### Version 1.0 - Core Features

- ✅ Basic task management system
- ✅ Firebase authentication and data sync
- ✅ Dark theme implementation
- ✅ User profile management

## Philosophy

Eternal Grind combines discipline with flexibility:

- **Consistent Progress**: Daily task completion builds habits
- **Flexible Scheduling**: Multiple duration options for different needs
- **Visual Organization**: Calendar view for better planning
- **Real-time Sync**: Access tasks anywhere, anytime

*"Discipline is the bridge between goals and accomplishment."*

## License

This project is developed for educational purposes and demonstration of Flutter capabilities.

## Repository

📁 **GitHub**: https://github.com/Soham-Patel1604/Eternal_Grind

For issues, feature requests, or contributions, please visit the repository.
