# `tar` Archives

That archive CLI with god-awful UX.

## Create `.tar.gz` Archive of a Directory

Pay attention to the trailing `.` which is relative to the directory set in `-C`.

```bash
tar czf my-archive.tar.gz -C my-directory .
```

## Create & Encrypt a Directory Into`.tar.gz.gpg`

This accepts a password from CLI argument. Maybe use `--passphrase-file` instead.

```bash
tar czf - -C "my-directory" . | gpg --batch --symmetric --passphrase "$PASSWORD" -o "my-archive.tar.gz.gpg"
```

