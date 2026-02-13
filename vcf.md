# VCF

Variant call format. AKA export/import/store contacts file.

## Check VCF Version

VCF version is in the header section of the file.

```bash
head -5 foo.vcf
```

## Bump VCF Version

Some systems only support newer versions of VCF. So you may need to bump the version.

```bash
git clone https://github.com/jowave/vcard2to3.git
cd vcard2to3
./vcard2to3.py foo.vcf
```
