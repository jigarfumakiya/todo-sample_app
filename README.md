<br>

# Todo Sample 📱

💡 A to-do app with a twist! 🎉 Not only can you see your incomplete and completed tasks, but you can also add new to-dos with a date and enjoy a smooth animation. 🤩 The app is built using Flutter Clean Architecture for a clean and organized codebase. 💻 Get organized and have fun with this Todo app!

## ⚙️ Pre-requisites:

| Technology | Recommended Version | Installation Guide                                                    |
|------------|---------------------|-----------------------------------------------------------------------|
| Flutter    | v3.0.4              | [Flutter Official Docs](https://flutter.dev/docs/get-started/install) |
| Dart       | v2.17.5             | Installed automatically with Flutter                                  |

## 🚀 Getting started is easy!

- Clone this project
- Run `flutter pub get`
- Run `flutter gen-l10n` to generate localization files
- Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate freezes files
- Run Test `flutter test`

## 🎉 Features included:

- [x] BLoC State Management
- [x] **Clean Architecture**
    - [x] Unit Test
    - [x] Widget Test
    - [x] BLoC test
- [x] Add new todos with date
- [x] Show Completed todos
- [x] Show Incomplete todos

### 📁 Project Structure:
Check out the detailed structure in the code!




````

lib/
├── config.dart
├── core
│   ├── app
│   │   ├── app_assets.dart
│   │   ├── app_colors.dart
│   │   └── app_constant.dart
│   │   └── app_routes.dart
│   │   └── app_text_style.dart
│   │   └── app_text_theme.dart
│   │   └── storage_utils.dart
│   ├── common
│   │   ├── other common widgets uses global 
│   ├── exceptions
│   │   ├── app_exceptions.dart
│   │   ├── other common widgets uses global
│   ├── extensions
│   │   ├── your custom extension for app
│   ├── helpers
│   │   ├── helpers methods
│   ├── injectors
│   │   ├── di 
│   ├── network
│   │   ├── dio_service.dart
│   │   ├── other network files
├── features
│   ├── todo
│   │   ├── data
│   │   │   ├── datasources
│   │   │   ├── models
│   │   │   └── repositories
│   │   ├── domain
│   │   │   ├── repositories
│   │   │   └── usecases
│   │   └── presentation
│   │       ├── addTodo
│   │       │   ├── bloc
│   │       │   ├── widget
│   │       └── home
│   │           ├── bloc
│   │           ├── widget
├── app.dart
├── app_cubit.dart
├── app_state.dart
├── landing_widget.dart
├── main.dart

````

