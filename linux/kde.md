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

## Addons and Scripts

Since there is no way to easily track down what you configured or installed upon
KDE, I will be keeping a list of addons and scripts here.

I use these kwin scripts:

- Mouse Tiler
- Remember Window Position

For Mouse tiler, I these layout settings:

```text
SPECIAL_MAXIMIZE
SPECIAL_FULLSCREEN
SPECIAL_NO_TITLEBAR_AND_FRAME
0,0,67,100+67,0,33,50+67,50,33,50
0,0,67,100+67,0,33,100
0,0,25,100+75,0,25,100+25,0,50,100
2x1
```
