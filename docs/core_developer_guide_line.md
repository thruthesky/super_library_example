# Core Developer’s Guideline

Developing a super library in the FlutterFlow dashboard is not recommended. It's much faster to develop using VSCode.

## Recommended Setup

1. **Create a Flutter Project**:
   1. Name the project `super_library_flutter_example`.

2. **Download the Super Library Code**:
   1. Use the VSCode extension `FF Download Code` to download the FlutterFlow Super Library code into the `super_library_flutter_example` Flutter project.

3. **Download the Example App Code**:
   1. Create a FlutterFlow app that consumes the super library.
   2. Use the VSCode extension `FF Download Code` to download the FlutterFlow example app that consumes the Super Library.

## Example Setup

Below are my(JaeHo, Song) setup;

1. **Create the Flutter Project**:
   1. Path: `/Users/thruthesky/apps/flutter/ff-libraries/super_library_example`

2. **Download the Super Library Code**:
   1. Path: `/Users/thruthesky/apps/flutter/ff-libraries/super_library_example/super-library-5mglde`

3. **Download the FlutterFlow Example Project**:
   1. Path: `/Users/thruthesky/tmp/ff-examples/test-super-library-ldkmay`

## Working with Multiple Projects

- Open all the three VSCode projects simultaneously.
- Edit the Super Library code within the `super_library_flutter_example` Flutter project.
- Test the Super Library code while editing it.
- Perform final tests in the FlutterFlow example project (`test-super-library-ldkmay`).

## Tips

- Use Git for version control: [GitHub Repository](https://github.com/thruthesky/super_library_flutter_example)
- For more information, contact the creator.
