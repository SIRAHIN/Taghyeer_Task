# Shoppy (Taghyeer Task)

A robust Flutter application that showcases modern Flutter development practices including state management, local database persistence, remote API integration, and pagination.

## Setup & Running the Project (FVM)

This project strictly utilizes [FVM (Flutter Version Management)](https://fvm.app/) to guarantee environment consistency. **Do not run standard `flutter` commands.**

**Prerequisites:**
You must have FVM installed. If you do not have it:
```bash
dart pub global activate fvm
```

**1. Install the specific Flutter SDK version used for this project:**
```bash
fvm install 3.27.1
```

**2. Set it as your active workspace version:**
```bash
fvm use 3.27.1
```

**3. Fetch dependencies:**
```bash
fvm flutter pub get
```

**4. Generate Freezed & Injectable files (if needed):**
```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

**5. Run the app:**
```bash
fvm flutter run
```

## Features Implemented

- **Product Listing & Pagination**: Displays a grid of products fetched from an API with infinite scrolling/pagination.
- **Post Listing & Pagination**: Displays a list of user posts fetched from an API with infinite scrolling/pagination.
- **User Authentication & Profile**: Handles user login, caches session data locally (Hive), and displays the user profile in the Settings view.
- **Dynamic Theme Management**: Supports persistent Light & Dark mode switching.
- **Internet Connectivity Monitor**: A global listener using `connectivity_plus` that dynamically displays a persistent, non-intrusive toast notification whenever the device loses internet connection.
- **Detail Screens**: Nested routing configurations via `go_router` to view individual Product and Post details.

## State Management & Architecture

- **State Management**: Developed using `flutter_bloc` (Cubit) for predictable and scalable state separation.
- **Code Generation**: extensively utilizes `freezed` and `json_serializable` for robust immutable state models and precise JSON parsing.
- **Dependency Injection**: Managed efficiently with `get_it` and `injectable`.
- **Local Storage**: Utilizes `Hive` for fast, lightweight local key-value storage (Theme preference & cached user data).
- **Networking**: Configured using `Dio` for structured network requests and interceptors.
- **Routing**: Handled by `go_router` for clean declarative routing and deep linking support.

## Project Structure Overview

The project adheres to a scalable feature-first / clean architecture approach:

```text
lib/
├── core/                  # Core utilities and configuration (Router, Theme, Constants)
├── data/                  # Data layer
│   ├── api_service/       # Remote API implementations (Dio interceptors and endpoints)
│   ├── internet_service/  # Network monitoring services
│   ├── local_db_source/   # Hive local storage implementations
│   └── repository/        # Abstract repositories bridging Data and Domain
├── domain/                # Domain models, entities, and Freezed generated files
├── presentation/          # UI / Presentation Layer
│   ├── bloc/              # Cubits organized by feature (Auth, Products, Posts, Theme, Internet)
│   ├── screens/           # UI Screens and bottom sheet fragments
│   │   ├── auth_screen/
│   │   ├── bottom_nav_screen/ # Main wrapper with IndexedStack persistence
│   │   ├── post_details/  
│   │   └── product_details/
│   ├── widgets/           # Global re-usable UI components
│   └── app.dart           # The root MaterialApp configuration and global Bloc providers
└── main.dart              # Global initializers, Dependency Injection, and Hive setup
```

