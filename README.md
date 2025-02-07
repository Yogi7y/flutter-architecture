# Flutter Architecture

## Setup & Running

### 1. Create Platform-Specific Projects

If you haven't created the platform-specific projects yet, run:

```bash
flutter create -i swift -a kotlin .
```

This will create iOS (Swift) and Android (Kotlin) projects in your existing Flutter project.

### 2. Host Mock API Locally

If you're using VSCode, the easiest way is using VS Code's Live Server:

1. Install "Live Server" extension in VS Code
2. Click on the "Go Live" button in the bottom right corner of the VS Code window or fuzzy find "Live Server" in the command palette (Ctrl+Shift+P/Cmd+Shift+P)
3. Server will start (typically on port 5500)

### 3. Update API Configuration

Update the API base URL in `lib/src/core/constants/api.dart` with your local IP:

```dart
abstract class Api {
  static const baseUrl = 'http://192.168.1.5:5500/'; // Update with your local IP
  static const orders = '/payload/orders/fetch.json';
}
```

To find your local IP:

- Windows: `ipconfig | findstr IPv4`
- Mac/Linux: `ifconfig | grep "inet "`

### 4. Run the App

Run the app using your preferred way.

Mock data is served from `payload/orders/fetch.json` which includes various order scenarios for testing different states and configurations.
