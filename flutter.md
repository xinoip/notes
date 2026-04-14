# Flutter

Flutter the UI toolkit from Google. It can be used to build GUIs for any
platform (nearly) from a single codebase but most of the time I use it for just
mobile development. Check also:

- [adb](adb.md)

## Toolchain Setup

- Check [setup guide](https://docs.flutter.dev/get-started/install)
- Install `android-studio` (srcpkg from void-packages)
- Run `android-studio` and install SDK to `~/3pp/android`
- Open SDK manager and install SDK CLI tools as well
- Install flutter by getting the `.tar.gz` release and store it at `~/3pp/flutter`
- Run `flutter doctor --android-licenses`
- Run `flutter doctor` and check if everything is fine
- Install flutter extension in VS Code to debug
- Following environment variables are used to locate SDKs:

```sh
export ANDROID_HOME=$HOME/3pp/android
export ANDROID_SDK_ROOT=$ANDROID_HOME
export FLUTTER_ROOT=$HOME/3pp/flutter
```

- Disable analytics:

```sh
flutter doctor --disable-analytics
flutter --disable-analytics
dart --disable-analytics
```

- Following needed for VS Code to find emulators:

```sh
flutter config --android-sdk ~/3pp/android
```

## Create Project

```bash
# can add additional platforms
flutter create --description "app desc in pub" --org com.orgname \
        --project-name my_proj --platforms=ios,android my-proj

# check help for create
flutter create help
```

## List Devices

Since Flutter can target multiple platforms, this command can list all available
target devices:

```sh
flutter devices
```
