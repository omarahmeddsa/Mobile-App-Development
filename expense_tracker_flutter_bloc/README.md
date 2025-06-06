# Expense Tracker App

A modern and intuitive expense tracking application built with Flutter and BLoC pattern. This app helps users manage their daily expenses with a beautiful UI and powerful features.

## Features

- 📊 **Expense Overview**: Visual representation of expenses through bar charts
- 💰 **Add Expenses**: Easy expense entry with categories and dates
- 📱 **Modern UI**: Clean and intuitive user interface
- 🎨 **Dark Theme**: Eye-friendly dark mode design
- 📈 **Category-wise Analysis**: Track expenses by different categories
- 🔄 **State Management**: Efficient state management using BLoC pattern
- 💾 **Data Persistence**: Local storage of expense data

## Screenshots

### Home Screen
![Home Screen](screenshots/home_screen.png,size=300x600)
*Main dashboard showing expense chart and list of expenses (Recommended size: 300x600px)*

### Add Expense Screen
![Add Expense](screenshots/add_expense.png,size=300x600)
*Form to add new expenses with category selection (Recommended size: 300x600px)*

> **Note**: For optimal display on GitHub, please ensure your screenshots are:
> - Width: 300-400 pixels
> - Height: 500-600 pixels
> - Format: PNG or JPG
> - File size: Under 500KB each

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code
- Android SDK / Xcode (for iOS development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/expense_tracker_flutter_bloc.git
```

2. Navigate to the project directory:
```bash
cd expense_tracker_flutter_bloc
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Dependencies

- `flutter_bloc`: ^9.1.1 - State management
- `hydrated_bloc`: ^10.0.0 - Persistent state management
- `fl_chart`: ^1.0.0 - Chart visualization
- `uuid`: ^4.5.1 - Unique ID generation
- `intl`: ^0.20.2 - Internationalization and formatting
- `path_provider`: ^2.1.2 - File system access

## Project Structure

```
lib/
├── controller/
│   ├── expense_tracker_bloc.dart
│   ├── expense_tracker_event.dart
│   └── expense_tracker_state.dart
├── model/
│   └── ExpenseModel.dart
├── pagecontroller/
│   ├── navigationcontroller_cubit.dart
│   └── navigationcontroller_state.dart
├── screens/
│   ├── homepage.dart
│   └── addexpensepage.dart
└── main.dart
```

## Features in Detail

### Expense Tracking
- Add expenses with title, amount, category, and date
- View expenses in a list format
- Delete expenses with a single tap
- Categorize expenses (Food, Shopping, Transport, Other)

### Data Visualization
- Bar chart showing expenses by category
- Interactive chart with tooltips
- Real-time updates when adding/removing expenses

### User Interface
- Bottom navigation for easy access to main features
- Animated transitions between screens
- Responsive design that works on all screen sizes
- Intuitive form for adding new expenses

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- BLoC pattern for state management
- All contributors who have helped in the development
