# Steps that need to be done manually (Windows 10)

## VMware virtual machines

### Enable forward/back mouse buttons

Add:

```
usb.generic.allowHID = TRUE
mouse.vusb.enable = "TRUE"
mouse.vusb.useBasicMouse = "FALSE"
```

to .vmx file in the virtual machine image directory.

### Turn off spectre and meldown mitigations in VMware

Add:

```
ulm.disableMitigations="TRUE"
```

to .vmx file in the virtual machine image directory.
