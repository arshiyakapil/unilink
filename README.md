# UniLink

A modern Flutter app for university students to sign up, log in, and connect with their campus community.

## Features

- Campus selection during signup
- ID card scanning (front & back) with image picker
- Auto-extraction of stream/year (mocked for now)
- Details form: section, hosteller status, password
- Login with registration number and password
- Navigation between screens using named routes
- Home/dashboard screen after login
- Backend API integration ready (Node.js + MongoDB)
- Local session persistence with `shared_preferences`

## Folder Structure

```
lib/
  main.dart
  screens/
    auth/
      login_screen.dart
      scan_or_enter_id_screen.dart
    signup_campus_screen.dart
    signup_idscan_screen.dart
    signup_details_screen.dart
    homepage.dart
  widgets/
    custom_button.dart
    input_field.dart
  models/
```

## Getting Started

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```
2. **Run the app:**
   ```bash
   flutter run
   ```

## API Integration

- Update API URLs in your screens to match your backend endpoints (e.g. `/api/signup`, `/api/login`).
- Use the `http` package for POST requests.
- Store tokens/user info with `shared_preferences` for persistent login.

## Customization

- Replace campus list, ID extraction logic, and dashboard UI as needed.
- Add error handling, loading spinners, and validation for production use.

## Contributing

Pull requests and suggestions welcome!

## License

MIT
# unilink

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
