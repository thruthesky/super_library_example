
# Quick Start

To use the Super Library, you need to add initialization code.

## Why Initialization is Needed

- **Web**: Firebase Realtime Database requires additional code for web applications.
- **Mobile**: Firebase Realtime Database works without extra code on mobile apps.

## Adding initApp Custom Action

Add the `initApp` custom action as shown below:

```dart
import 'package:super_library/custom_code/actions/super_library.dart';

Future initApp() async {
  SuperLibrary.instance.init(
    getDatabaseUrl: () => FFDevEnvironmentValues().databaseURL,
    debug: true,
  );
}
```

## Explanation

**getDatabaseUrl**: A callback function to return the database URL. It Supports environment variables, which are initialized after initApp is called.
If not using environment variables, simply return the URL as a string.

## Handling Errors

If you see an error like Target of URI doesn't exist: 'package:super_library/custom_code/actions/super_library.dart', run the app with "Exclude from compilation".

## Adding initApp to main.dart
Make sure to add the initApp custom action in your main.dart file.