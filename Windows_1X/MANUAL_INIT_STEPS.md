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

### Mouse & display

1. Go to: `Control Panel\All Control Panel Items\Ease of Access Center\Make the mouse easier to use`
2. Mouse pointers -> "Extra large White"
3. Set: "Activate a window by hovering over it with the mouse"
4. Go to: `Control Panel\All Control Panel Items\Ease of Access Center\Make computer easier to use`
5. Set: "Make the focus rectangle thicker" and set the thickness of the blinking cursor to 4
6. Set: "Turn off unnecessary animations" (when possible)


### Taskbar

#### Right-click on the taskbar
- Toolbars - disable all
- Search -> Hidden
- Show ... -> disable all except "Show Windows Ink Workspace button"
- taskbar settings
    * all off except the following
    * use small taskbar buttons -> on
    * replace command prompt with Windows PowerShell in the menu (Win + X)
    * taskbar location on screen -> top
    * Combine taskbar buttons -> When taskbar is full
    * show taskbar on all displays -> on
    * show taskbar buttons on -> Taskbar where window is open
    * Combine buttons on other taskbars -> When taskbar is full
    * Show news and interests on the taskbar -> on, Icon, and text
    * everything else is off
 
### Personalization - settings

1. Go to Windows Settings -> Personalization

#### Start menu

- Show app list in start menu -> on
- Show recently added apps -> on
- Show most used apps -> on
- Show recently opened items in Jump Lists on start or the taskbar and in file explorer Quick access -> on
- Choose which folders appear on Start -> Settings and Personal folder

#### Background

- set it to some gray color

#### Colors

- Choose your color - dark - IMPORTANT
- Window colors -> Blue (or some other contrast color wrt. the window borders)
- Show accent color on the following surfaces -> Title bars and window borders -> CHECK - IMPORTANT

#### Themes

- Mouse Cursor - Windows Standard (extra large)
- Save my theme

####

- Fonts - Adjust ClearType text - go over the wizard

### Accessibility settings

- Text cursor - Turn on text cursor indicator (pink, 1/4 size)
- (maybe - Display - Show animations in Windows - off? - that is already set above with greater granularity)
- (maybe - Display -> make text bigger to around 105%)
- night light settings - from 21 to 7, 50%

### System - settings

1. Go to Windows Settings -> System

- Power & Sleep - set all to Never - but set the screen to turn off after 45 minutes
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
- Click on the "Advanced" tab
- Click "Settings" in the "Performance" section
- Select "Let Windows choose...."
- Additionally, to that deselect:
    * "Animate controls and elements inside Windows" (so that virtual desktops are switched instantly)
    * "Animate windows when minimizing and maximizing" (it will also improve the speed of switching virtual desktops)
    * "Animations in the taskbar"
    * "Fade or slide menus into view"
    * "Fade or slide ToolTips into view"
    * "Show shadows under windows"
    * ... TODO find out what other options are doing
 
## Set first day of week

1. Right-click at the clock/calendar widget in the taskbar
2. Adjust date/time
3. Related settings (link) - Date, time & regional formatting
4. Regional format data - change data formats
5. First day of week - Monday

## Logiops

1. Fix a bug that causes gestures to be way too insensitive:
   a. Go to Logiops and increase the sensitivity to 81
   b. Go to Windows mouse settings and decrease the sensitivity to 4 ticks (in the standard mouse settings dialog, not the advanced)
   note: there are two sliders for setting the pointer speed that work independently in Windows, one is in the settings app
   and another is in the advanced mouse settings dialog

## AltSnap

1. Remap AltSnap key to Win

## XPpen tablet

1. Install drivers and follow the settings guide in CommonInitScripts (todo add link)

## Install Slovak eID drivers

(TODO - make it automatic)

## Powertoys

### Set keyboard shortcuts in Powertoys

1. Always on top
2. shortcuts for switching virtual desktop via keyboard shortcuts remapping

## Review & check preinstalled sw and drivers

1. Review preinstalled sw & drivers
2. uninstall bloatware (todo - titus debloater? https://github.com/ChrisTitusTech/winutil )
3. Turn off system services I don't need
4. update windows and drivers
5. check tat all necessary drivers are installed and work
6. Run ookla speedtest on all network inferfaces

## Desktop icons - organize

# TODO

- Do some research on how Sync your settings work in Windows and set it up
- adjust ClearType text
- play around with fractional scaling
- adjust text size
- download additional fonts
- study this - in order to automatize more: <https://learn.microsoft.com/en-us/windows-hardware/get-started/?view=windows-11>
- Optimizations from <https://www.youtube.com/watch?v=RswaXcWWCo0> and <https://www.youtube.com/watch?v=uCVc-7z-toE>
