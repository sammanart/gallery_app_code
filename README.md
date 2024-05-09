# Gallery App 

A Gallery App project created in flutter using Cubit BLoC. 

# Getting Started

## Local Setup

1. Let us get [Flutter](https://docs.flutter.dev/get-started/install) onto your development machine
2. Make sure that you follow the steps to setup your preferred IDE.
   We recommend [Android Studio](https://docs.flutter.dev/get-started/editor?tab=androidstudio).

MacOS:
Xcode is required for running iOS simulators and building iOS applications for store submission.

### Common commands that you will need to know when using Flutter

```
Run the diagnostic tool for Flutter 
~ flutter doctor 

Checking the current installed Flutter version 
~ flutter --version

Upgrading the current Flutter version to the latest available stable release version of Flutter
~ flutter upgrade

This runs a clean removing the installed pub packages of the project (does not affect the pods)
~ flutter clean 
```

# Getting the application running

### Android builds

```
Install pub packages specified in the pubspec.yaml
~ flutter pub get

Update the pub get packages specified in the pubspec.yaml
Note: This will not change the version specified in the pubspec.yaml
~ flutter pub upgrade
```

### iOS builds

Follow the Android steps and after that run these additional steps

For Intel MacBook's

```
Change directory to the iOS folder
~ cd ios

Install the cocoapods for the flutter pub packages
~ pod install

Update the installed pods
Note: This will not change the version specified in the pubspec.yaml
~ pod update
```

For Apple Silicon (you have to specify the architecture)

```
Change directory to the iOS folder
~ cd ios

Install the cocoapods for the flutter pub packages
~ arch -x86_64 pod install

Update the installed pods
Note: This will not change the version specified in the pubspec.yaml
~ arch -x86_64 pod update
```

## Architecture guidelines

* The application uses
  the [BloC architecture with cubits](https://www.youtube.com/watch?v=mSXKvWjojpo) as state
  management.

* ### The basic structure is:
    * config - The config folder includes the configuration about the app (themes, routes, …etc) nothing more
    * core - The core folder is much more important, it includes the core stuff we need across the app (globally) so if we have a job/action that will be required by all (features/layers) then it’s better to be in the core. It also includes some other folder such as (resources, utiles, …etc).
    * data - The data folder is a place where the app meets with the harsh outside world of APIs and 3rd party libraries. It consists of low-level Data Sources, Repositories which are the single source of truth for the data, and finally Models.
    * domain - The domain folder contains only the internal entities and what this mean is that our domain’s entities are completely independent from any changes that could occur outside this layer.
    * presentation - The presentation folder contains two important parts: The Blocs (also ViewModels) and The UI


# Author

Name: ***Samvel Manukyan***

