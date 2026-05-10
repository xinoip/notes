# GPG

GPG keys can do a lot and are very confusing.

## Temporary GPG Directory

This is a good security measure. Create a temporary `GNUPGHOME` directory and
use that during the key generation process:

```sh
export GNUPGHOME=$(mktemp -d)
```

## Hardware Security Keys/Cards (like YubiKey)

You can modify the card settings using `gpg -- card-edit`. Change the PIN and
admin PIN this way.

If you are using a YubiKey, I find `ykman` tool to be easier. Check out the
[./yubikey.md](./yubikey.md) for more information.

## Generating a Master Key

A master key is generated and needs to be backed up securely. This will be used
to generate all kinds of subkeys.

```sh
gpg --expert --full-generate-key
```

It will be created interactively so select these settings:

- (11) ECC (set your own capabilities)
- Toggle 'signing' capability off. Only leave 'certify' on.
- (1) Curve 25519
- Set expiry time e.g. 1y 2y etc.
- Fill rest.

Note the key ID. Now we start to generate subkeys with `gpg --expert --edit-key
<KEY_ID>`:

- addkey, (10) ECC (sign only), Curve 25519
- addkey, (12) ECC (encrypt only), Curve 25519
- addkey, (11) ECC (set your own capabilities), Curve 25519, only Auth
  capability
- save

Back up your master key:

```sh
# Make sure to back this string up somewhere safe
gpg --armor --export-secret-keys <KEY_ID>
```

At this point, delete your master key from the keyring and local machine.
Continue using your subkeys instead. Only use the master key from your backup to
further generate subkeys or revoke them.

## Moving Keys to a Hardware Security Device (like YubiKey)

Start by: `gpg --edit-key <KEY_ID>`

To send a key to the card:

- `key 1` to select the key (an asterisk will appear)
- `keytocard` to send the key to the card
- `key 1` to deselect the key

Repeat this for all keys. Essentially, you will have:

1. Signing key
2. Encryption key
3. Authentication key

Don't forget to type `save` after you are done.

## Using Key Servers

Key servers holds the public keys for various people and services. You can
upload your own keys to a key server or verify someone else's key.

```sh
gpg --keyserver hkps://keys.openpgp.org --search-keys <KEY_ID/NAME/EMAIL>
gpg --keyserver hkps://keyserver.ubuntu.com --send-keys <KEY_ID>
```

## Sanity Check

Check your keyring and diagnose any issues:

```sh
# List keys in keyring
gpg -K
# ssb lines are subkeys. If they have a `>` character, it means they are on the
# hardware security device.

# Check card connection
gpg --card-status

# Try to sign something
echo "Hello Keys" | gpg --clearsign

# Reload to clear state
gpgconf --reload gpg-agent

# Encrypt and decrypt something
echo "This is a top secret message" | gpg --encrypt --recipient "your@email.com" | gpg --decrypt
```

## Deleting Keys

```sh
gpg --delete-secret-keys <KEY_ID>
```

## Export Public Key

Use this to send someone your public key:

```sh
gpg --armor --export <KEY_ID> > mypublic.asc
```

## Import Public Key

Use this to import someone's public key:

```sh
gpg --import mypublic.asc
```

Keys can be imported from a key server too:

```sh
# Will give an option to import it
gpg --keyserver hkps://keys.openpgp.org --search-keys my@email.com
```
