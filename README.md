# Premium Todo App

A beautiful, feature-rich Flutter todo application with persistent local storage.

## Features

- **Task Management**: Create, complete, and delete tasks with ease
- **Priority Levels**: Assign Low, Medium, or High priority to tasks
- **Filter Tasks**: View All, Active, or Completed tasks
- **Dark/Light Theme**: Toggle between dark and light modes
- **Local Storage**: All data persists across app restarts
- **Undo Support**: Restore deleted tasks with undo functionality
- **Progress Tracking**: Visual progress bar showing completion percentage

## Screenshots

The app features a modern, gradient-based UI with:
- Smooth animations and transitions
- Swipe-to-delete functionality
- Floating action button for quick task addition
- Statistics overview (Total, Active, Done counts)

## Getting Started

### Prerequisites

- Flutter SDK (3.10.7 or higher)
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/todo_app.git
   cd todo_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── todo_item.dart        # Todo data model
│   └── todo_filter.dart      # Filter enum
├── pages/
│   └── todo_list_page.dart   # Main page
├── providers/
│   ├── todo_provider.dart    # Todo state management
│   └── theme_provider.dart   # Theme state management
├── services/
│   └── storage_service.dart  # Local storage persistence
├── theme/
│   └── app_theme.dart        # Light/Dark theme definitions
├── utils/
│   ├── colors.dart           # Color palette
│   └── constants.dart        # App constants
└── widgets/
    ├── add_button.dart       # Gradient add button
    ├── add_task_sheet.dart   # New task bottom sheet
    ├── filter_bar.dart       # Task filter tabs
    ├── header_section.dart   # Page header with stats
    ├── priority_selector.dart # Priority selection widget
    ├── stats_row.dart        # Task statistics display
    ├── theme_toggle.dart     # Theme toggle button
    ├── todo_card.dart        # Individual task card
    └── todo_list_view.dart   # Task list with swipe actions
```

## Technical Details

### State Management
- Uses `Provider` package for state management
- `TodoProvider` manages all todo operations with local storage persistence
- `ThemeProvider` handles theme switching with saved preference

### Local Storage
- Uses `shared_preferences` for data persistence
- Tasks are saved as JSON and restored on app launch
- Theme preference is saved separately

### Data Model
```dart
class TodoItem {
  final String title;
  final String description;
  final int priority;      // 1: Low, 2: Medium, 3: High
  final bool isCompleted;
}
```

## Dependencies

- `provider` - State management
- `shared_preferences` - Local storage
- `google_fonts` - Typography

## License

This project is open source and available under the MIT License.