# 🎬 Flutter Assessment: TMDB Popular People App

This is a personal Flutter project built as part of a technical assessment. 
The app integrates with [The Movie Database (TMDB)](https://www.themoviedb.org/)
API to display a list of popular people (actors, directors, etc.) and allows users to view and download their images.

---


---

## 📸 Preview

| People Screen | Person Details | Image Grid |
|---------------|----------------|------------|


---

## 📁 Project Structure


lib/
├── core/              # Shared logic, global utils, networking, etc.
│   ├── network/       # API service, Dio/interceptors, etc.
│   ├── utils/         # Constants, formatters, helpers
│   └── widgets/       # Reusable UI widgets (buttons, cards, etc.)
├── features/
│   └── people/        # TMDB 'people' feature module
└── main.dart          # App entry point


## 📱 Features

✅ Fetch and display a list of popular people using TMDB API  
✅ Infinite scroll with lazy loading  
✅ Detailed view for each person (name, profile, department, etc.)  
✅ Grid view of the person’s images  
✅ Full-size image preview with save-to-device functionality

---

## 🛠️ Technologies

- **Flutter**
- **Dart**
- **TMDB REST API**
- `http` package for network calls
- `flutter_dotenv` for managing API keys securely

---

## 🧪 How to Run Locally

1. **Clone the repo:**
   ```bash
   git clone https://github.com/yourusername/flutter-tmdb-assessment.git
   cd axis_assessment
