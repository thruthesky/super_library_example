# Dart Extensions

## String Extensions

### `or` Method

The `or` method replaces the string with the provided parameter if the original string is null or empty.

#### Example

```dart
user.displayName.or('...')
```

In this example, if user.displayName is null or empty, it will be replaced with '...'.
