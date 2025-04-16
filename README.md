# Encora Community

This is a Flutter project for the **Encora Community** app, designed to manage teams, display team details, and offer an interactive and visually appealing user experience.

## Features

- **Manager Detail Page**: A dedicated page for displaying the details of a manager, including their profile information, avatar, description, and team progress.
- **Expandable Cards**: Each team is represented by an expandable card, showing detailed information about the team’s responsibilities and other aspects when expanded.
- **Dynamic Mock Data**: Uses mock data for teams and their details to simulate a real-life scenario. Data includes team names, percentage completion, and team roles.
- **Custom UI Components**: Focus on clean design, user-friendly interactions, and easy navigation. The UI includes custom avatars, icons, and completion percentage indicators for each team.
- **Firebase Authentication**: Implements Firebase Auth for secure user login and authentication. Includes a login page and manager dashboard with real-time user authentication.

## Technologies Used

- **Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase**: Used for authentication and backend services.
- **Provider**: Used for state management.
- **Dart**: The programming language used with Flutter.

## Getting Started

To run this project locally, follow these steps:

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/encora_community.git
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the app**:

   ```bash
   flutter run
   ```

This will start the app on your emulator or connected device.

## Project Structure

- `lib/`: Contains all the main code for the app.
  - `models/`: Contains the data models used throughout the app (e.g., `UserHeaderModel`, `ExpandableCardModel`).
  - `widgets/`: Contains reusable UI components like `AppHeader`, `ExpandableCard`, etc.
  - `pages/`: Contains the page-specific widgets like `ManagerDetailPage`.
  - `data/`: Stores mock data for teams, managers, and other elements used in the app.

## Resources

If you're new to Flutter, check out these resources to get started:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, and a full API reference.

## Author

- **Lucas Hellanio**  
  Founder and Developer of the Encora Community app.
