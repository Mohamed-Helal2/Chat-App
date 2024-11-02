# ChatApp

A Flutter-based real-time chat application using Firebase and Google Maps API, built with clean architecture.

## Project Overview

This project is a fully-featured chat application built with Flutter, designed for seamless communication, media sharing, and location-based interactions. The app features a responsive UI and real-time updates, with support for both online and offline usage.

## Features

- **Messaging**: Send text messages with real-time updates.
- **Media Sharing**:
  - Multiple photos, videos, and PDFs.
  - Voice recordings.
  - Emoji support with a custom emoji picker.
- **Location Sharing**: Share current location using Google Maps.
- **Message Actions**:
  - Read/unread message status indicators.
  - Swipe to reply to specific messages.
- **Offline Support**: Messages are saved locally using `SharedPreferences` for offline access.
- **Push Notifications**: Firebase Messaging enables notifications for new messages.
- **User Interface**:
  - Clean, modern, and responsive UI with `flutter_screenutil`.
  - Custom animations using Lottie.
- **Additional Features**:
  - Google Sign-In for secure authentication.
  - Customizable launch icons and splash screen.

## Dependencies

### Core Packages

- `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`, `firebase_messaging`: Firebase services for authentication, storage, and real-time updates.
- `google_sign_in`: Google authentication integration.
- `flutter_bloc`: State management using Cubit/Bloc.
- `flutter_screenutil`: Responsive layout support.
- `shared_preferences`: Local storage for offline support.

### Media & File Handling

- `image_picker`, `file_picker`: For selecting images and files.
- `flutter_sound`, `audioplayers`: For recording and playing audio.
- `photo_view`: For viewing media in full screen.

### UI and Icons

- `font_awesome_flutter`: Font icons for UI elements.
- `lottie`: For adding animations.
- `cached_network_image`: Caching images for improved performance.
- `emoji_picker_flutter`: Custom emoji picker.

### Utilities

- `dartz`, `get_it`, `equatable`: Used for functional programming and dependency injection.
- `internet_connection_checker`: To monitor internet connectivity.
- `permission_handler`: To manage app permissions.
- `intl`: For internationalization and localization support.

### Additional Tools

- `flutter_native_splash`: For splash screen customization.
- `flutter_launcher_icons`: To customize app icons.

## Configuration

- **Adaptive App Icon**: Set up for both Android and iOS with a custom icon.
- **Supported Android Version**: Minimum SDK version set to 21.

### Fonts

- Custom font: PTSerif (for a unique app aesthetic).

## Getting Started

If this is your first Flutter project, refer to these resources to get started:

- [Flutter: Write Your First App](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook: Useful Samples](https://docs.flutter.dev/cookbook)

For Flutter documentation, check out [Flutter Documentation](https://docs.flutter.dev/), which includes tutorials, samples, and a full API reference.

---

Excited to launch this app and bring seamless communication to everyone!
