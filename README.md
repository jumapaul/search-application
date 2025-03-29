# search

## Interview Solution

👀 Solution code for search application for cross_platform using [flutter](https://flutter.dev/).
The final app looks like this:

#### LIGHT THEME

| Landing                    | Search for user repos         | Non existing user search       | 
|----------------------------|-------------------------------|--------------------------------|
| ![Landing](images/one.png) | ![User repos](images/two.png) | ![Non-users](images/three.png) | 

#### DARK THEME

| Landing                         | Search for user repos              | Non existing user search          |  
|---------------------------------|------------------------------------|-----------------------------------|
| ![Landing](images/dark_one.png) | ![User repos](images/dark_two.png) | ![Non-users](images/dark_two.png) |

### Prerequisites

- Before running this app, you need to have java 19 installed:

- Ensure the minimum sdk set above 21 and multiDexEnabled set to true on app/build.gradle:

```shell script
    defaultConfig {
        minSdk = 23
        multiDexEnabled true
    }
```

- Ensure the compile sdk is set to 34:

```shell script
    android {
    compileSdk = 34
```

- Once the project is set up, run:

```
    flutter pub get
```

### Background

The data will be provided by the following API -> https://api.github.com/

endpoint to use: https://api.github.com/users/{user}/repos{?type,page,per_page,sort}
The application would have only 1 screen - Repository search screen

### Requirements:

Repository search screen should have a search bar on the top, repositories should be searched by
it’s owner account username

    1. Each row should display username, avatar, and repository name.
    2. The list should be paginated, use ‘page’ and ‘per_page’ API endpoint query params.
    3. Implement error and loading states.
    4. Use your preferred best practices.
    5. Share solution via Github.

## Tech-stack

* Framework
    * [Flutter](https://flutter.dev/) - a cross-platform, statically typed, general-purpose
      programming language with type inference.

* State management
    * [Getx](https://chornthorn.github.io/getx-docs/) - For state management, navigation, and
      dependency injection.

* Tests
    * [Mockito]() - For mocking dependencies during unit tests.

## Dependencies

All the dependencies (external libraries) are defined in the single place - pubspec.yaml.

## License

```
MIT License

Copyright (c) 2025 Juma Paul

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

