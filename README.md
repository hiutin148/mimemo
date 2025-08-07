# Mimemo Weather App (Personal Practice Project)

<p align="center">
  <img src="/screenshots/home.png" width="150">
  <img src="/screenshots/hourly.png" width="150">
  <img src="/screenshots/daily.png" width="150">
  <img src="/screenshots/radar.png" width="150">
  <img src="/screenshots/minutecast.png" width="150">
  <img src="/screenshots/dailydetail.png" width="150">
</p>

<p align="center">
  A modern weather forecasting application built with Flutter for self-study and practice purposes.
</p>

---

## 🌟 About This Project

<p>This project is a personal endeavor to practice and solidify my skills in Flutter development. It's
a feature-rich weather application that showcases a good architecture, modern UI, and the
integration of various popular Flutter libraries. 
This app is based on both the UI and API of
the <a href="https://play.google.com/store/apps/details?id=com.accuweather.android&hl=en">
AccuWeather app</a>.</p>
<p>
You can try this app with below APK.
</p>
<p>
    <a src="https://drive.google.com/file/d/1fIEdZ4vOklnzbB1P9v8Qa70ER0ON--lq/view?usp=sharing">
        <img src="screenshots/apk.png" width="50"/>
    </a>
</p>

### ✨ Core Features

- **Real-time Weather:** Current temperature, humidity, wind speed, and more.
- **Hourly & Daily Forecasts:** Detailed forecasts to plan ahead.
- **Rain Forecast (Next 4 Hours):** See expected precipitation over the next 4 hours.
- **Air Quality Index (AQI):** Air quality information for your location.
- **Weather Radar:** View real-time weather radar data overlaid on Google Maps.
- **Geolocation:** Automatic location detection for local weather.
- **Location Search:** Search and save locations to track weather worldwide.

---

## 🛠️ Tech Stack & Architecture

I try to build this project with a focus on clean code and a scalable architecture.

### Key Libraries & Technologies

- **State Management:** `flutter_bloc`
- **Routing:** `auto_route`
- **Networking:** `dio`, `retrofit`
- **Dependency Injection:** `get_it`
- **Local Storage:** `shared_preferences`
- **Geolocation:** `geolocator`, `geocoding`
- **UI:** `flutter_svg`, `cached_network_image`, `shimmer`
- **Firebase:** `firebase_core`, `firebase_messaging`
- **Supabase:** `supabase_flutter`
- **Linting:** `very_good_analysis`

## Project Architecture

The project follows a layered architecture focused on a clear separation of concerns, inspired by
principles from Clean Architecture. The structure is organized as follows:

- **Data Layer**: This layer is responsible for all data handling.
    - `services`: Communicate with external sources like REST APIs and device services (e.g.,
      geolocation).
    - `repositories`: Abstract the data sources and provide a clean API for the business logic layer
      to access data.
    - `models`: Define the data structures (entities) used throughout the application.

- **Business Logic Layer**:
    - `Cubits/Blocs`: At the core of the business logic, these components from the `flutter_bloc`
      library manage the application's state. They interact with the repositories to fetch and
      process data, and then expose the state to the UI.

- **Presentation Layer (UI)**:
    - `screens` & `widgets`: Comprises all the Flutter widgets that form the user interface. These
      widgets listen to state changes from the Cubits/Blocs and rebuild themselves to reflect the
      current state.

This approach promotes a reactive and maintainable codebase, where UI, business logic, and data
sources are decoupled.

---

## 📂 Project Structure

```
lib/
├── common/
│   ├── blocs/
│   └── utils/
├── core/
│   ├── base/
│   ├── const/
│   └── extension/
├── generated/
│   └── intl/
├── l10n/
├── models/
│   ├── entities/
│   └── enums/
├── repositories/
├── router/
    ├── app_router.dart
    └── app_router.gr.dart
├── services/
│   ├── api/
│   ├── shared_preference_service.dart
│   ├── fcm_service.dart
│   ├── supabase_function_service.dart
│   └── local_notification_service.dart
├── ui/
│   ├── screens/
│   │   ├── air_quality/
│   │   │   ├── air_quality_screen.dart
│   │   │   └── widgets/
│   │   ├── bottom_nav/
│   │   │   ├── bottom_nav_cubit.dart
│   │   │   └── bottom_nav_screen.dart
│   │   ├── daily/
│   │   │   ├── daily_cubit.dart
│   │   │   ├── daily_screen.dart
│   │   │   ├── daily_state.dart
│   │   │   └── widgets/
│   │   ├── home/
│   │   │   ├── home_cubit.dart
│   │   │   ├── home_screen.dart
│   │   │   ├── home_state.dart
│   │   │   └── widgets/
│   │   ├── ...
│   │   └── splash/
│   │       ├── splash_cubit.dart
│   │       └── splash_screen.dart
│   └── widgets/
├── firebase_options.dart
├── locator.dart
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK

### Installation & Setup

1. **Clone the repository:**
   ```sh
   git clone https://github.com/hieunt/mimemo.git
   ```

2. **Navigate to the project directory:**
   ```sh
   cd mimemo
   ```

3. **Install dependencies:**
   ```sh
   flutter pub get
   ```

4. **Run the build runner to generate necessary files:**
   ```sh
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the application:**
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
- Draw complex widgets using CustomPainter.
- Displaying weather radar data overlaid on Google Maps.
- Handling notifications with FCM and local notifications.

This project is for my personal portfolio and to demonstrate my Flutter skills.

---

## 📝 Future Plans (TODO)

- [ ] Implement caching for API responses to reduce network usage.
- [ ] Add more detailed weather information (e.g., UV index, visibility).
- [ ] Implement theme switching (light/dark mode).
- [ ] Implement localization (was planned from the start, but I forgot).
- [ ] Integrate Google AdMob (also forgot to add this earlier).
- [ ] Add unit and widget tests.
- [ ] Refactor the UI to be more responsive for different screen sizes.
