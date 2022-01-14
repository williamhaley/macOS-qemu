# macOS on Qemu

Use another macOS machine to create a USB installer the standard/normal way and then copy off the `BaseSystem.dmg` file or use some of the modern scripts available online to download the `dmg` direct from Apple.

The `dmg` can be converted to a raw image like so.

```
qemu-img convert BaseSystem.dmg -O raw BaseSystem.img
```

Then run these steps:

1. gather-files.sh
1. setup.sh

# Notes

* https://www.reddit.com/r/hackintosh/
* https://dortania.github.io/OpenCore-Install-Guide/
* https://github.com/kholia/OSX-KVM
