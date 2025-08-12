# Findoc Assignment - Flutter Application

A Flutter application with login and home screens using BLoC state management, validation, and API integration.

## Features

### Login Screen
- **Email Field**: Validates email format using regex
- **Password Field**: Validates password requirements:
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one numeric digit
  - At least one symbol
- **Submit Button**: Processes login with loading state
- **Navigation**: Transitions to home screen on successful login

### Home Screen
- **Image Gallery**: Fetches and displays 10 images from Picsum API
- **Responsive Layout**: Images adjust width to screen width with dynamic height based on aspect ratio
- **Typography**: Uses Montserrat font family as specified
- **Pull-to-Refresh**: Refresh images by pulling down
- **Error Handling**: Displays error states with retry functionality
- **Logout**: Logout button in app bar

## Technical Implementation

### State Management
- **BLoC Pattern**: Uses flutter_bloc for state management
- **AuthBloc**: Handles login/logout states
- **HomeBloc**: Manages image loading states

### API Integration
- **Picsum API**: Fetches images from https://picsum.photos/
- **HTTP Package**: For API calls
- **Error Handling**: Comprehensive error handling for network issues

### Validation
- **Email Validation**: Regex-based email format validation
- **Password Validation**: Comprehensive password strength validation
- **Real-time Feedback**: Shows validation errors in real-time

### UI/UX
- **Material Design 3**: Modern Material Design implementation
- **Google Fonts**: Montserrat font family integration
- **Responsive Design**: Adapts to different screen sizes
- **Loading States**: Proper loading indicators throughout the app

## Clean Project Structure

```
findoc assignment/
├── pubspec.yaml              # Dependencies configuration
├── README.md                 # Documentation
├── .gitignore               # Git ignore rules
├── analysis_options.yaml    # Linting rules
├── web/                     # Web platform files
└── lib/                     # Main application code
    ├── main.dart            # Application entry point
    ├── models/
    │   ├── user.dart        # User model
    │   └── image_item.dart  # Image model
    ├── blocs/
    │   ├── auth/            # Authentication BLoC
    │   │   ├── auth_bloc.dart
    │   │   ├── auth_event.dart
    │   │   └── auth_state.dart
    │   └── home/            # Home screen BLoC
    │       ├── home_bloc.dart
    │       ├── home_event.dart
    │       └── home_state.dart
    ├── screens/
    │   ├── login_screen.dart # Login screen UI
    │   └── home_screen.dart  # Home screen UI
    ├── services/
    │   └── api_service.dart  # Picsum API integration
    └── utils/
        └── validation.dart   # Validation utilities
```

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or iOS Simulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd findoc-assignment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome
   ```

### Testing the Application

1. **Login Screen**:
   - Enter a valid email (e.g., `test@example.com`)
   - Enter a password that meets all requirements (e.g., `TestPass123!`)
   - Tap "Sign In" to proceed

2. **Home Screen**:
   - Images will load automatically
   - Pull down to refresh images
   - Tap logout button to return to login screen

## Dependencies

- `flutter_bloc`: ^8.1.3 - State management
- `equatable`: ^2.0.5 - Value equality
- `http`: ^1.1.0 - HTTP requests
- `google_fonts`: ^6.1.0 - Google Fonts integration

## API Endpoints

- **Picsum API**: `https://picsum.photos/v2/list?limit=10`
- **Image URLs**: `https://picsum.photos/id/{id}/{width}/{height}`

## Notes

- The login functionality is simulated for demo purposes
- Any valid email/password combination that meets the validation requirements will work
- Images are fetched from the Picsum API which provides random placeholder images
- The app uses Material Design 3 with a modern, clean UI
- All text uses the Montserrat font family as specified in the requirements
- Project has been cleaned up to remove unnecessary files and dependencies 