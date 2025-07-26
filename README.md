# 🎬 Flutter Assessment: TMDB Popular People App

This is a personal Flutter project built as part of a technical assessment. 
The app integrates with [The Movie Database (TMDB)](https://www.themoviedb.org/)
API to display a list of popular people (actors, directors, etc.) and allows users to view and download their images.

---

## 📱 Features

✅ **People Discovery**
- Fetch and display popular people from TMDB API
- Infinite scroll pagination with smooth loading
- Offline support with intelligent caching
- Network recovery when connection returns

✅ **Advanced Image Viewing**
- Full-screen image viewer with zoom & pan gestures
- Interactive viewer (pinch to zoom, drag to pan)
- High-quality cached image loading
- Elegant loading states and error handling

✅ **Smart Download System**
- Download images directly to device gallery
- Automatic filename generation with person names
- Real-time download progress indicators
- Success/error feedback with snackbars

✅ **Offline-First Architecture**
- Seamless online/offline experience
- Intelligent data caching with Hive
- Graceful pagination when offline
- Automatic sync when network returns

✅ **Modern UI/UX**
- Clean, intuitive design
- Smooth animations and transitions
- Dark theme support for image viewing
- Responsive layout for different screen sizes


---

## 🛠️ Technologies & Packages

**Core Framework:**
- Flutter & Dart
- BLoC Pattern for state management

**Networking & Data:**
- TMDB REST API integration
- Dio for HTTP requests with interceptors
- Hive for local caching and offline storage
- Network connectivity monitoring

**UI & Media:**
- CachedNetworkImage for optimized image loading
- InteractiveViewer for zoom/pan functionality
- Gal package for gallery integration
- Custom loading states and error widgets

**Architecture:**
- Clean Architecture principles
- Repository pattern with offline-first approach
- Cubit-based state management
- Dependency injection

---

## 📸 App Screenshots

| People List | Person Details | Image Viewer | Download Feature |
|-------------|----------------|--------------|------------------|

### Key UI Features:
- **Infinite Scroll:** Smooth pagination with loading indicators
- **Image Zoom:** Interactive viewer with pinch-to-zoom and pan gestures
- **Download Progress:** Real-time feedback during image downloads
- **Offline Indicator:** Visual feedback when using cached data
---

## 📁 Project Structure


lib/
├── core/                          # Shared core functionality
│   ├── const/                     # App-wide constants
│   ├── di/                        # Dependency injection setup
│   ├── error/                     # Error and failure models
│   ├── networking/               # API services, results, constants, and Dio factory
│   ├── routing/                  # App router and route definitions
│   ├── services/                 # Platform-independent services (e.g., Hive, connectivity)
│   ├── utils/                    # Utility functions and styles
│   └── widgets/                  # Reusable core widgets (e.g., text fields, wrappers)
│
├── features/                     # Feature-based modules
│   ├── image_download/           # Feature: Image downloading and saving
│   │   └── presentations/
│   │       ├── cubit/            # Image download Cubit and states
│   │       └── views/            # Image download view UI
│   │
│   └── people/                   # Feature: People (e.g., TMDB people or user list)
│       ├── data/
│       │   ├── models/           # Data models for people
│       │   └── repository/       # People repository implementation
│       ├── domain/
│       │   └── repository/       # Abstract repository interface
│       └── presentations/
│           ├── cubit/           # People Cubit and states (with pagination)
│           └── views/
│               ├── widgets/     # People-specific reusable widgets
│               ├── people_view.dart
│               └── person_details_view.dart
│
└── main.dart                    # App entry point


---

## 🧪 How to Run Locally

1. **Clone the repo:**
   ```bash
   git clone https://github.com/yourusername/flutter-tmdb-assessment.git
   cd axis_assessment
