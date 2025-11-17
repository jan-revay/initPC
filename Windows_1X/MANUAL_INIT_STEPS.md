# Steps that need to be done manually (Windows 11)


## If on VM or additional Windows partition

### Activate windows

- using the official key on the main partition
- using <https://massgrave.dev/> elsewhere (might be reinstalled often...) TODO verify reliability & safety
      -  https://www.google.com/search?q=userguide+get.activated.win&rlz=1C1GCEA_enSK1157SK1157&oq=userguide+get.activated.win&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIKCAEQABiABBiiBDIHCAIQABjvBTIKCAMQABiABBiiBDIHCAQQABjvBdIBCDQ0MTlqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8

## File explorer

- Hide extensions of known file types - disable
- bookmark ~/x folder
- bookmark ~ folder

## VMware virtual machines

### Enable forward/back mouse buttons

Add:

```
usb.generic.allowHID = TRUE
mouse.vusb.enable = "TRUE"
mouse.vusb.useBasicMouse = "FALSE"
```

to .vmx file in the virtual machine image directory.

### Turn off Spectre and Meltdown mitigations in VMware

Add:

```
ulm.disableMitigations="TRUE"
```

to .vmx file in the virtual machine image directory.

## Windows settings that are not yet automated

### Enable SVK QWERTY and EN-US keyboard layouts

Restart the PC afterwards, if I am unable to remove unneeded keyboard layouts, use this manual to
remove them in the Windows registry: <https://superuser.com/questions/957552/how-to-delete-a-keyboard-layout-in-windows-10/1340511#1340511>

### Mouse & display

1. Go to: `Control Panel\All Control Panel Items\Ease of Access Center\Make the mouse easier to use`
2. Mouse pointers -> "Windows Inverted (extra-large)"
3. Set: "Activate a window by hovering over it with the mouse"
4. Mouse settings -> "Hide pointer while typing" -> uncheck (TODO test how it works)
5. Go to: `Control Panel\All Control Panel Items\Ease of Access Center\Make computer easier to use`
6. Set: "Make the focus rectangle thicker"
7. Set the thickness of the blinking cursor to 3
8. Set: "Turn off unnecessary animations" (when possible)
9. Set: Turn High Contrast on or off when left ALT + left SHIFT + PRINT SCREEN is pressed -> uncheck

### Taskbar

#### Right-click on the taskbar
- Toolbars - disable all except "Task view"
- Search -> Hide
- Show ... -> disable all except "Show Windows Ink Workspace button"
- taskbar settings
    * all off except the following:
    * Use small taskbar buttons -> on
    * Replace the command prompt with Windows PowerShell in the menu (Win + X)
    * Combine taskbar buttons -> When taskbar is full
    * show taskbar on all displays -> on
    * show taskbar buttons on -> Taskbar where window is open
    * Combine buttons on other taskbars -> When taskbar is full
    * Show news and interests on the taskbar -> on, Icon, and text
    * Everything else is off
 
### Personalization - settings

1. Go to Windows Settings -> Personalization

#### Start menu

- Layout -> More pins -> Check
- Show the most used apps -> Check
- Show recommended files in start, recent files in File Explorer, and items in Jump lists -> on
- Show recommendations for tips, shortcuts, new app,s and more -> off
- Show app list in start menu -> on
- Show recently added apps -> on
- Show most used apps -> on
- Show recently opened items in Jump Lists on start or the taskbar and in file explorer Quick access -> on
- Choose which folders appear on Start -> Settings and Personal folder

#### Display

- Night light
  - Strength -> max
  - Schedule -> 20:30 to 7:00

### System -> Storage
- Automatic user content cleanup -> off

### System -> For developers
- File Explorer
  - Show file extensions
  - Show full path in title bar
- terminal
  - Windows terminal

#### Background

- Set it to some gray color

#### Colors

- Choose your color - dark - IMPORTANT
- Window colors -> Red (or some other contrast color wrt. the window borders)
- Show accent color on the following surfaces -> Title bars and window borders -> CHECK - IMPORTANT

#### Themes

- Mouse Cursor - Windows Inverted (large) (system scheme)
- Save my theme

####

- Fonts - Adjust ClearType text - go over the wizard

### Accessibility settings

- Text cursor - Turn on text cursor indicator (pink, 1/4 size)
- (maybe - Display - Show animations in Windows - off? - that is already set above with greater granularity)
- (maybe - Display -> make text bigger to around 105%)
- Visual effects -> Always show scrollbars -> on?

### System - settings

1. Go to Windows Settings -> System

- Power mode - set to "Best performance"/"Ultimate performance"
- Power & Sleep - set all to Never - but set the screen to turn off after 45 minutes
- Multitasking
    * snap windows -> on (plus all related checkboxes)
    * Alt + Tab -> open windows only
    * Virtual desktops -> On taskbar show windows that are open on -> On all desktops
    * Alt + Tab shows windows that are open on -> Only the desktop I'm using
- Clipboard -> clipboard history -> on (Pressing Win + V displays the history)

### Turn off unnecessary animations in advanced settings

- Right-click the Start menu and select System from the context menu.
- This will take you to Control Panel > System and Security > System.
- Now click "Advanced system settings".
- Click on the "Advanced" tab
- Click "Settings" in the "Performance" section
- Select "Let Windows choose..."
- Additionally, to that deselect:
    * "Animate controls and elements inside Windows" (so that virtual desktops are switched instantly)
    * "Animate windows when minimizing and maximizing" (it will also improve the speed of switching virtual desktops)
    * "Animations in the taskbar"
    * "Fade or slide menus into view"
    * "Fade or slide ToolTips into view"
    * Optional "Show shadows under windows"
    * Show window contents while dragging
    * ... TODO find out what other options are doing
 
#### Hibernation file and pagefile in the advanced settings

- ~~turn off the hibernation file (run `powercfg.exe /hibernate off` as administrator, this is already done in initPC script)~~
- set the pagefile size to 12882MB min - 20GB max (system properties -> Advanced -> Performance options -> Advanced -> Virtual Memory)
 
## Set the first day of the week

1. Right-click on the clock/calendar widget in the taskbar
2. Adjust date/time
3. Related settings (link) - Date, time & regional formatting
4. Regional format data - change data formats
5. First day of the week - Monday

### Time & language -> Typing -> Advanced keyboard settings

- Let me set a different input method for each app window -> check

## Logiops

1. Fix a bug that causes gestures to be way too insensitive:
    1) Go to Logiops and increase the sensitivity to 80 <https://www.reddit.com/r/logitech/comments/ssvuh8/set_exact_dpi_for_mx_master_3_logitech_options/>
    2) Go to Windows mouse settings and decrease the sensitivity to 2 ticks (in the standard mouse settings dialog, not the advanced)
       Note: There are two sliders for setting the pointer speed that work independently in Windows, one is in the settings app
       and another is in the advanced mouse settings dialog
1. SmartShift: Set smartshift sensitivity to 90%

## AltSnap

1. Remap AltSnap key to Win

##  windows-virtualdesktop-helper

- run from start menu -> taskbar icon right click -> Settings
  - Show Previous / Next Desktop in Icon Tray -> uncheck
  - Show Overlay when switching Desktop -> 500ms
    - Animate In/Out -> Uncheck
    - Position -> Top, middle
- Use Hot Keys to Jump to Desktop -> Alt+#
- Startup with Windows

## XPpen tablet

1. Install drivers and follow the settings guide in DistroAgnostic (todo add link)

## Install Slovak eID drivers

(TODO - make it automatic)

## Schedule tasks

- HddOff script at startup
- Shutdown at 21:00 until 7:00

## Keyboard shortcut

- set Ctrl+alt+T to open terminal (create a shortcut to the terminal on the desktop and add the shortcut key) [https://chatgpt.com/c/680438c7-db18-800d-b762-57f179a19e69](https://chatgpt.com/share/68043ead-db74-800d-a457-967cff5d6627)

## Powertoys

### Set keyboard shortcuts in Powertoys

1. Always on top
2. Shortcuts for switching virtual desktop via keyboard shortcuts remapping

## Review & check preinstalled sw and drivers

1. Review preinstalled sw & drivers
2. Uninstall bloatware (todo - titus debloater? https://github.com/ChrisTitusTech/winutil )
3. Turn off system services I don't need
4. Update Windows and drivers
5. Check that all necessary drivers are installed and work
6. Run ookla speedtest on all network inferfaces

## Desktop icons - organize

## Install programs that are not in Winget

- Ryzen master
- AMD chipset drivers
- AMD adrenaline
- OCCT + license
- Install motherboard drivers & utilities (ASUS: Driverhub - default tab + "Driverhub individual kits")
- Rufus
- Cinebench
- AutoLogon
- XPpen drivers
- Zentimings
- y-cruncher
- **[Crucial storage executive](https://www.crucial.com/support/storage-executive)**

## Install VMware Workstation Pro (or VirtualBox)

## Tune the initPC script again and check for errors resp. apps that did not install

# TODO

- Do some research on how Sync your settings work in Windows, and set it up
- Adjust ClearType text
- play around with fractional scaling
- Adjust text size
- Download additional fonts
- study this - in order to automate more: <https://learn.microsoft.com/en-us/windows-hardware/get-started/?view=windows-11>
- Optimizations from <https://www.youtube.com/watch?v=RswaXcWWCo0> and <https://www.youtube.com/watch?v=uCVc-7z-toE>
