# Package Info

This custom action provides an API for querying information about an application package. It works on iOS, Android, and Web.

## Usage

You can use the `packageInfo` action to query information about the application package.

## Response

The `packageInfo` custom action will return the following information in JSON format:

```json
{
  "appName": "app name",
  "packageName": "package name",
  "version": "version",
  "buildNumber": "build number"
}
```
