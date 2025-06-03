# Farm2Kitchen AI

Farm2KitchenAI is a smart mobile app that helps users access farm-fresh products and intelligently manage kitchen inventory. Built with Flutter and powered by Firebase, it integrates user authentication, cloud storage, and real-time database features to deliver a seamless experience.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Tech Stack

- **Flutter** – Cross-platform UI development
- **Firebase** – Authentication, Firestore DB, Cloud Functions
- **OpenAI/Farm NLP (optional)** – Intelligent recipe/produce recommendations
- **Cloud Storage** – For uploading product images or receipts

## Folder Structure

- `lib/` – Dart code for frontend screens, services, and logic
- `android/`, `ios/`, `linux/` – Platform-specific build directories
- `functions/` – Firebase Cloud Functions (Node.js backend)
- `assets/` – App assets (images, icons, etc.)
- `firebase.json`, `firestore.rules`, `firestore.indexes.json` – Firebase config

## Getting Started

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/farm2kitchen.git
cd farm2kitchen
```

2. **Install Flutter dependencies:**
```bash
flutter pub get
```

3. **Connect to Firebase:**
- Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
- Update `firebase.json` and initialize Firebase project using `firebase init`.

4. **Run the app:**
```bash
flutter run
```

## Features

- **User Authentication** (Email & Google Sign-In)
- **Browse Local Produce** from verified farmers
- **Smart Kitchen Tips** (recommendations via ML/NLP models)
- **Inventory Reminders** and slot booking
- **Real-time Sync** using Firestore
- **Mobile-first UI** for smooth experience

## Prototype

![App prototype:](.png)

## Future Enhancements

- Voice-based recipe search
- Integration with IoT kitchen sensors
- AI-based produce freshness estimator
