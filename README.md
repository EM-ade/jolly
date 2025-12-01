# Jolly - Podcast Streaming App

A modern, feature-rich podcast streaming application built with Flutter.

## 🚀 Steps to Run the Project

### Prerequisites
- Flutter SDK (Latest Stable Version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- An Android Emulator or Physical Device

### Installation
1. **Clone the repository**
   ```bash
   git clone https://github.com/EM-ade/jolly.git
   cd lofty
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## 🛠 State Management Approach

This project uses **Riverpod** for state management.

### Why Riverpod?
- **Compile-safe**: Catches provider errors at compile time rather than runtime.
- **No BuildContext dependency**: Allows reading providers from anywhere, making logic easier to test and reuse.
- **Great for Async**: Built-in support for `AsyncValue` makes handling loading, error, and data states for API calls seamless (used extensively in the Podcast Player).
- **Scalability**: Easy to combine providers and manage complex state dependencies.

**Key Providers:**
- `authProvider`: Manages user authentication state (Login/Signup).
- `playerProvider`: Handles audio playback state (Play/Pause, Seek, Duration).
- `podcastRepositoryProvider`: Dependency injection for the data layer.

## 🧐 Assumptions Made

1. **API Quirks**: I noticed the API returns data in a pretty deeply nested format (sometimes `data.data.data`). I assumed this was the standard structure for these endpoints and wrote the parsing logic to dig down and get the actual content we needed.
2. **User Flow**: For the onboarding, I assumed we wanted to guide new users through the phone signup flow first. However, I added a direct "Login" link on the phone screen because it's much smoother for existing users (and for testing!).
3. **Image Handling**: Some of the image URLs coming from the API were a bit hit-or-miss. I assumed it was better to show a clean placeholder or fallback image rather than letting the UI break or show error icons, so I implemented `CachedNetworkImage` with proper error widgets.

## 🚀 Improvements with More Time

If I had a bit more time to polish this up, here's what I'd tackle next:

1.  **Background Audio**: This is the big one. Right now the player works while the app is open, but for a real podcast app, you need to be able to lock your phone or switch apps and keep listening. I'd integrate a background audio service to handle that and show controls in the notification shade.
2.  **Better Caching**: I'd add some local storage (like Hive) to cache the API responses. That way, if your internet drops out, you don't stare at a blank screen—you'd still see the content you loaded previously.
3.  **Refactoring the API Layer**: We moved fast to get the features working, which means some of that nested data parsing logic is sitting directly in the repositories. I'd love to move that into a dedicated interceptor to keep the code cleaner and more maintainable.
4. **Complete Other Pages and Features**: I'd love to complete the other pages, such as the episodes page, profile page and also some functionalites like the search functionality.
4.  **Solid Testing**: I'd add proper unit tests, especially for the authentication flow and the player logic. It gives you that extra peace of mind that a new update won't accidentally break the core features.
