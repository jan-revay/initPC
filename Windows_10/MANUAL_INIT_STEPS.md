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

## Windows settings that are not yet automatized

### Mouse

1. Go to: `Control Panel\All Control Panel Items\Ease of Access Center\Make the mouse easier to use`
2. Mouse pointers -> "Large White"
3. Consider "Activate a window b hoverin over it with the mouse"

### Taskbar

#### Rhight click on the taskbar
- Toolbars - disable all
- Search -> Hidden
- Show ... -> disable all except "Show Windows Ink Wokspace button"
- taskbar settings
    * all off except following
    * use small taskbar buttons -> on
    * replace command prompt with Windows PowerShell in the menu (Win + X)
    * taskbar location on screen -> top
    * Combine taskar buttons -> When taskabar is full
    * show taskbar on all displays -> on
    * show taskabr buttons on -> Taskbar where window is open
    * Combine buttons on other taskbars -> When taskbar is full
    * Show news and interests on the taskbar -> on, Icon and text
    * everyting else is off
 
### Personalization - settings

1. Go to Windows Settings -> Personalization

#### Start menu

- Show app list in start menu -> on
- Show recently added apps -> on
- Show most used apps -> on
- Show recently opened itels in Jump Lists on start or the taskbar and in file explorer Quick access -> on
- Choose which folders appear on Start -> Settings and Personal folder

### System - settings

1. Go to Windows Settings -> System

- Power & Sleep - set all to Never
- Multitasking
    * snap windows -> on (plus all related checkboxes)
    * Alt + Tab -> open windows only
    * Virtual desktops -> On taskbar show windows that are open on -> Only the desktop I'm using
    * Alt + Tab shows windows that are open on -> Only the desktop I'm using
- Clipboard -> clipboard history -> on (Pressing Win + V displays the history)

### Turn off unnecessary animations in advanced settings

- Right-click the Start menu and select System from the context menu.
- This will take you to Control Panel > System and Security > System.
- Now click "Advanced system settings".
- Click to "Advanced" tab
- Click "Settings" in "Performance" section
- Select "Let Windows choose...."
- Additionally to that desellect:
    * "Animate windows when minimizing and maximizing" (it will also improve speed of switching virtual desktops)
    * "Fade or slide ToolTips into view"
    * "Animations in the taskbar"
    * ... TODO find out what other options are doing


# TODO

- Do some research on how Sync your settings work in Windows and set it up
- adjust ClearType text
- play around with fractional scaling
- adjust text size
- download additional fonts
- study this - in order to automatize more: <https://learn.microsoft.com/en-us/windows-hardware/get-started/?view=windows-11>
- Optimizations from <https://www.youtube.com/watch?v=RswaXcWWCo0> and <https://www.youtube.com/watch?v=uCVc-7z-toE>
