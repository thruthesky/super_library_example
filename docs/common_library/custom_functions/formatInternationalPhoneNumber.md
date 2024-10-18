# formatInternationalPhoneNumber function

The function accepts `dialCode` and `mobileNumber` and returns the phone number in the international format. If it cannot format the phone number, it returns an empty string. If the phone number is an empty string, the FlutterFlow will display an error message of `Phone Number Validation Message`. You can customize this message to something like `Please input a valid phone number` in the language settings.

Note: The returned value may not be an exact international phone number format, but it is sufficient for use in FirebaseAuth phone sign-in.

Note: It's a good idea to allow users to input only numbers. Set the input keyboard type to "number" or "phone number" for better user experience.



```dart
String formatInternationalPhoneNumber(String dialCode, String mobileNumber);
```

Below are the test code of `formatInternationalPhoneNumber`.

```dart

void runTests() {
  // Test cases
  List<Map<String, dynamic>> testCases = [
    {
      'dialCode': '+82',
      'mobileNumber': '010-1234-5678',
      'expected': '+821012345678'
    }, // Valid case
    {
      'dialCode': '1',
      'mobileNumber': '1234567890',
      'expected': '+11234567890'
    }, // Valid case (US number)
    {
      'dialCode': '+44',
      'mobileNumber': '(020) 1234-5678',
      'expected': '+442012345678'
    }, // Valid case (UK number with formatting characters)
    {
      'dialCode': '82',
      'mobileNumber': '010 1234 5678',
      'expected': '+821012345678'
    }, // Valid case (without +)
    {
      'dialCode': '+49',
      'mobileNumber': '01520-1234567',
      'expected': '+4915201234567'
    }, // Valid case (German number)
    {
      'dialCode': '+1',
      'mobileNumber': 'abc-1234-5678',
      'expected': ''
    }, // Invalid mobile number (contains letters)
    {
      'dialCode': '+abc',
      'mobileNumber': '01012345678',
      'expected': ''
    }, // Invalid dial code (contains letters)
    {
      'dialCode': '123+',
      'mobileNumber': '01012345678',
      'expected': ''
    }, // Invalid dial code (plus sign in wrong position)
    {
      'dialCode': '82',
      'mobileNumber': '01012345678#',
      'expected': ''
    }, // Invalid mobile number (contains symbols)
    {
      'dialCode': '+61',
      'mobileNumber': '0412345678',
      'expected': '+61412345678'
    }, // Valid case (Australia number)
    {
      'dialCode': '+82',
      'mobileNumber': '010123',
      'expected': ''
    }, // Invalid mobile number (too short)
    {
      'dialCode': '+82',
      'mobileNumber': '0101234567890123',
      'expected': ''
    }, // Invalid mobile number (too long)
    {
      'dialCode': '+1',
      'mobileNumber': ' 1111 1111- 1 1 ',
      'expected': '+11111111111'
    },
    {
      'dialCode': '+1',
      'mobileNumber': '0 1111 1111- 1 1 ',
      'expected': '+11111111111'
    },
    {
      'dialCode': '+63',
      'mobileNumber': '0 917 1234-5-6 7 8 ',
      'expected': '+6391712345678'
    },
  ];

  int passed = 0;
  int failed = 0;
  List<String> failedTests = [];

  // Run each test case
  for (var testCase in testCases) {
    String result = formatInternationalPhoneNumber(
        testCase['dialCode'], testCase['mobileNumber']);
    if (result == testCase['expected']) {
      passed++;
    } else {
      failed++;
      failedTests.add(
          'Test failed for Dial code: ${testCase['dialCode']}, Mobile: ${testCase['mobileNumber']} -> The result is empty string, Result: $result');
    }
  }

  // Print test results
  print('Total tests: ${testCases.length}');
  print('Passed: $passed');
  print('Failed: $failed');

  // Print detailed info for failed tests
  if (failed > 0) {
    print('\nFailed test cases:');
    for (var failedTest in failedTests) {
      print(failedTest);
    }
  }
}

void main() {
  runTests();
}
```


