# Mimemo Weather App (Personal Practice Project)

<p align="center">
  <img src="https://raw.githubusercontent.com/hieunt/mimemo/main/assets/icons/sun_cloud.svg" width="150">
</p>

<p align="center">
  A modern weather forecasting application built with Flutter for self-study and practice purposes.
</p>

---

## 🌟 About This Project

This project is a personal endeavor to practice and solidify my skills in Flutter development. It's a feature-rich weather application that showcases a clean architecture, modern UI, and the integration of various popular Flutter libraries.

### ✨ Core Features

- **Real-time Weather:** Current temperature, humidity, wind speed, and more.
- **Hourly & Daily Forecasts:** Detailed forecasts to plan ahead.
- **Air Quality Index (AQI):** Air quality information for your location.
- **Geolocation:** Automatic location detection for local weather.
- **Location Search:** Search and save locations to track weather worldwide.
- **Dynamic UI:** The UI changes based on the current weather conditions.

---

## 🛠️ Tech Stack & Architecture

This project is built with a focus on clean code and a scalable architecture.

### Architecture

- **Layered Architecture:** The project is organized into distinct layers: Presentation (UI), Business Logic (Repositories, Services), and Data. This separation of concerns makes the codebase modular, scalable, and easier to maintain.
- **Repository Pattern:** The data layer utilizes the Repository Pattern to abstract data sources, providing a clean API for the business logic layer to access data.
- **BLoC for State Management:** The `flutter_bloc` package is used for state management, ensuring a predictable and robust state flow throughout the application.
- **Dependency Injection:** `get_it` is employed for service location and dependency injection, decoupling components and improving testability.

### Key Libraries & Technologies

- **State Management:** `flutter_bloc`
- **Routing:** `auto_route`
- **Networking:** `dio`, `retrofit`
- **Dependency Injection:** `get_it`
- **Local Storage:** `shared_preferences`
- **Geolocation:** `geolocator`, `geocoding`
- **UI:** `flutter_svg`, `cached_network_image`, `fl_chart`, `shimmer`
- **Linting:** `very_good_analysis`

---

## 📂 Project Structure

```
lib/
├── main.dart               # App entry point
├── locator.dart            # Service locator setup (GetIt)
├── router/                 # Navigation setup (auto_route)
├── core/                   # Core utilities, extensions, and constants
│   ├── base/               # Base classes for Cubits/Blocs
│   ├── const/              # App constants (colors, themes, etc.)
│   └── extension/          # Dart extensions
├── models/                 # Data models
│   ├── entities/           # Data models from the API
│   └── enums/              # Enums used in the app
├── repositories/           # Data layer (fetches data from APIs)
├── services/               # Business logic services (geolocation, notifications)
└── ui/                     # Presentation layer
    ├── screens/            # UI for each screen
    └── widgets/            # Reusable UI components
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/hieunt/mimemo.git
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd mimemo
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the build runner to generate necessary files:**
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Run the application:**
    ```sh
    flutter run
    ```

---

## 📝 Personal Learnings & Takeaways

This project has been a great learning experience. Some of the key takeaways include:

- A deeper understanding of state management with BLoC.
- Implementing a clean and scalable project structure.
- Integrating various third-party libraries in a Flutter project.
- Working with REST APIs and handling asynchronous data.

This project is for my personal portfolio and to demonstrate my Flutter skills. It is not intended for open-source contributions.

---

## 📝 Future Plans (TODO)

- [ ] Implement caching for API responses to reduce network usage.
- [ ] Add more detailed weather information (e.g., UV index, visibility).
- [ ] Implement theme switching (light/dark mode).
- [ ] Add unit and widget tests.
- [ ] Refactor the UI to be more responsive for different screen sizes.
