# KDE

KDE applications and desktop environment on Linux.

## Force Reload

Get rid of issues quickly. Just a simple on/off process for desktop environment.

```sh
plasmashell --replace &
```

## Sys-Tray Icons Disappear After Changing Refresh Rate

Since watching media on 120 Hz offers better interpolation compared to 175 Hz, I
often find myself changing the refresh rate setting on KDE. This results in
system tray icons disappearing from the main bar.

Someone reported the issue [on KDE discussions](https://discuss.kde.org/t/changing-refresh-rate-loses-some-systray-icons/44973).

I don't have a permanent fix for now. Just [[kde#Force Reload]] the desktop environment
to fix it.
