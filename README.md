# Cats App in Flutter

## Features

- **Splash Screen**: It runs automatically once the app has started.
- **Cat List**: It will automatically trigger a Cat List Screen with cats taken from TheCatApi (Http Request).
- **Cat Search**: As soon as the user fill the search input, it triggers automatically the cat search and filters by breed name.
- **Cat Details**: As soon as the user selects a cat, the system triggers a new activity with information about the selected cat.
- **API Rest Client**: The system implements a layer to make http interaction called WebClient.

## Getting Started

To use this project, follow the instructions below:

### Prerequisites

Ensure you have Flutter installed on your machine. For more information on installing Flutter, refer to the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation

#### Clone the repo
   ```bash
   git clone https://github.com/miguelnfuertesc/test-pragma.git
   ```
#### Install dependences
   ```bash
   flutter pub get
   ```
#### Launch the app on an android device
   
   ```bash
   # list all emulators
   flutter emulators
   ```
   ```bash
   # launch the emulators
   flutter emulators --launch id
   ```
   ```bash
   # launch the app
   flutter run
   ```