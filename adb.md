# adb

Android Debug Bridge (ADB) notes.

## Enable Developer Options

It goes like: `Settings` > `About phone` > `Build number (tap alot)` > `Enable
developer options`.

## Start Daemon Manually

Daemon start automatically most of the time but here goes the manual way:

```sh
adb tcpip 5555
```

## Connect over Wi-Fi

Enable Wi-Fi debugging from developer options. Select option "Pair with code":

```sh
# Port for pairing and connection tend to be different
adb pair <ip>:<port> <code>
adb connect <ip>:<port>

# Device should be listed here
adb devices
```

## Open Shell to Device

```sh
adb -s <ip> shell
```

## List Installed Packages

While in shell:

```sh
pm list packages --user 0
```

## De-Bloat Android Device

Since new phones come with a lot of sh*t-ware, `adb` is godsend to easily clean
up the mess.

- [Universal
  De-Bloater](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation):
  GUI with community defaults.
