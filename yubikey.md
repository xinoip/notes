# Yubikey

Hardware security key.

## Install

On a Void Linux system, I installed these:

```bash
# CLI tool called "ykman".
xi yubikey-manager

# Support packages.
xi u2f-hidraw-policy gnupg2-scdaemon pcsc-ccid pcsclite
```

## Configure

Use `ykman` CLI tool to configure the Yubikey:

```bash
# Overview of current yubikey.
ykman info

# Has cascading help menu. Use that to find your way around.
ykman -h
ykman config -h
ykman config nfc -h
```


### Disable What You Don't Need

Check with `ykman info`. Disable what you don't need with:

```bash
ykman config usb -d otp
ykman config nfc -d otp
```

Final `ykman info` looks something like this:

```text
Applications	USB     	NFC
Yubico OTP  	Disabled	Disabled
FIDO U2F    	Disabled	Disabled
FIDO2       	Enabled 	Enabled
OATH        	Disabled	Disabled
PIV         	Disabled	Disabled
OpenPGP     	Enabled 	Enabled
YubiHSM Auth	Disabled	Disabled
```

## OpenPGP Quirks

If you want to use `ykman openpgp` for configuring or viewing your OpenPGP setup on key, you need to have a different
support daemon to be running on the system.

First start by killing any `gpg` daemon that might be running:

```bash
gpgconf --kill all
```

Then run `pcscd` daemon on demand (There is no need to enable it as a service. Just run it when you need):

```bash
# On Void Linux, this is the service entry point.
sudo /etc/sv/pcscd/run
```

After this, you should be able to run `ykman openpgp info` successfully.

But for `gpg` to work correctly, don't use `pcscd` daemon. Instead use the usual `gpg` programs and daemons.
