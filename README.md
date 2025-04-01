# Sehat-Khidmat

A healthcare and medical service mobile application built with Flutter that helps users book medical appointments and order medicines.

## Features

- **Appointment Booking**: Schedule appointments with doctors based on specialization
- **Medicine Ordering**: Order medicines by uploading prescriptions  
- **Communication Options**: Contact healthcare providers through calls or voice messages
- **User-Friendly Interface**: Intuitive navigation with a modern UI design

## Technologies Used

- **Flutter**: UI framework for cross-platform mobile development
- **Firebase**: Backend services integration
- **Supabase**: Database and authentication services
- **Dependencies**:
  - curved_navigation_bar: For bottom navigation
  - intl: For date formatting
  - image_picker: For prescription image uploads
  - url_launcher: For phone call functionality
  - font_awesome_flutter: For enhanced icons

## Screenshots

The application includes:
- Appointment booking screen
- Medicine ordering screen
- Navigation drawer for easy access to all features

## Getting Started

### Prerequisites

- Flutter SDK (^3.6.1)
- Dart SDK
- Android Studio or VS Code
- An emulator or physical device for testing

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/shabbeerumer/Sehat-Khidmat.git
   ```

2. Navigate to the project directory:
   ```
   cd Sehat-Khidmat
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart             # Application entry point
├── firebase_options.dart # Firebase configuration
├── view/                 # UI screens
│   └── home/
│       ├── Appointments.dart # Appointment booking screen
│       └── medicine.dart     # Medicine ordering screen
└── widgets/              # Reusable UI components
```

## Configuration

The application uses Supabase and Firebase for backend services. Make sure to:
1. Configure Firebase by following the instructions in the Firebase console
2. Set up a Supabase project and update the URL and anon key in main.dart

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any questions or suggestions, please reach out to shabbeerumer@gmail.com.
