# Women_Safety_SIH

# 🛡️ Women Safety App

Welcome to the **Women Safety App** – your personal security companion designed to ensure your safety with a range of powerful features. This app is built using the Flutter framework, and the code is organized in a modular structure for easy scalability and maintenance.

---

## 📋 Features

### 1. 👤 **User Authentication**
   - 🔑 Sign-up, sign-in, and sign-out functionalities.
   - 📝 User profile management.

### 2. 🚨 **SOS Alerts**
   - 🆘 Send an emergency SOS alert with a single tap.
   - 📍 Real-time location sharing included in the alert sent to selected contacts.
   - 🛰️ Integration with the device's GPS for accurate location tracking.

### 3. ☎️ **Helpline Contacts**
   - 📞 A directory of important helpline numbers categorized by type (e.g., police, women helplines, medical emergencies).
   - 📲 Direct calling or messaging from within the app.

### 4. 📚 **Educational Resources**
   - 📖 Access to articles, videos, and tips on safety measures, self-defense, and legal rights.
   - 📆 Regular updates on safety guidelines and recommendations.

### 5. 📱 **Fake Call Feature**
   - 📳 Simulate an incoming call to help escape uncomfortable or dangerous situations.
   - ⏰ Customize the caller name and the timing of the fake call.

### 6. 🌐 **Location Sharing**
   - 🗺️ Real-time location sharing with trusted contacts during emergencies.
   - ✋ Option to stop sharing location once the situation is under control.

### 7. 🔔 **Push Notifications**
   - 📝 Receive timely notifications for safety tips, alerts, and updates.
   - 🚨 Notifications for emergency situations like natural disasters or civil unrest.

### 8. 🛠️ **Onboarding and Tutorials**
   - 🎓 User-friendly onboarding process to guide new users through the app’s features.
   - 📘 In-app tutorials on how to effectively use the SOS and Fake Call features.

---

## 🗂️ Project Structure

The project is organized into different modules to enhance code readability and maintainability. Here’s a brief overview of the directory structure:

```plaintext
lib/
│
├── models/                   # Data models
│   ├── user_model.dart
│   ├── sos_model.dart
│   ├── helpline_model.dart
│   └── ...
│
├── viewmodels/               # View models managing the state and logic for views
│   ├── home_screen_viewmodel.dart
│   ├── education_viewmodel.dart
│   ├── sos_viewmodel.dart
│   ├── fake_call_viewmodel.dart
│   └── helpline_viewmodel.dart
│
├── views/                    # UI components, organized by feature
│   ├── home_screen/
│   │   ├── home_screen_view.dart
│   │   └── ...
│   ├── education/
│   │   ├── education_view.dart
│   │   └── ...
│   ├── sos/
│   │   ├── sos_view.dart
│   │   └── ...
│   ├── fake_call/
│   │   ├── fake_call_view.dart
│   │   └── ...
│   ├── helpline/
│   │   ├── helpline_view.dart
│   │   └── ...
│   └── common/               # Common views like splash screen, onboarding, etc.
│       ├── splash_screen_view.dart
│       ├── onboarding_screen_view.dart
│       ├── signin_signup_view.dart
│       └── ...
│
├── services/                 # Services like API calls, location tracking, etc.
│   ├── api_service.dart
│   ├── location_service.dart
│   ├── notification_service.dart
│   └── ...
│
├── repositories/             # Data access and management repositories
│   ├── user_repository.dart
│   ├── sos_repository.dart
│   ├── helpline_repository.dart
│   └── ...
│
├── utils/                    # Utility classes and functions
│   ├── constants.dart
│   ├── theme.dart
│   ├── routes.dart
│   └── ...
│
├── main.dart                 # Application entry point
└── app.dart                  # Application setup and configuration

🚀 Getting Started
✅ Prerequisites
Flutter SDK
Android Studio / Xcode (for iOS development)
An Android or iOS device/emulator
📦 Installation
Clone the repository:

bash
Copy code
git clone https://github.com/yourusername/women-safety-app.git
cd women-safety-app
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
⚙️ Configuration
API Integration: Set up your backend API endpoint in api_service.dart.
Location Services: Ensure location permissions are handled properly on both Android and iOS.
🤝 Contributing
We welcome contributions to improve the app. Please check out our contribution guidelines to get started.

📄 License
This project is licensed under the MIT License. See the LICENSE file for more details.

Feel free to modify this README to fit the specifics of your project. If you have any questions or need assistance, don't hesitate to reach out!

