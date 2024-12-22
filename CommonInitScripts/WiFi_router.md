# WiFi router config (Huawei HG8145X6 FTTH, Orange)

1. "WLAN" tab
    1. Set SSID and PW on 2.4 GHz and 5Ghz WiFI.
1. "System tools" tab
    1. Turn off led indicators ("Indicator Status Management" -> "Indicator Switch" -> Off).
    1. Turn off "Enable Energy Saving" ("Advanced power management" -> "Enable Energy Saving" - uncheck).
1. 5G Advanced Network Settings:
    1. Turn off "Band Steering" on 5 GHz WiFi.
    1. Set the 5GHz "channel" to fixed 100 (see: <https://en.wikipedia.org/wiki/List_of_WLAN_channels>) if it is not interfering with a neighbor's WiFI (use Android WiFi analysis tools to investigate). Note: Channel 100 is a good choice because it has fewer devices on it as lower channels do and it has enough space for a continuous 80MHz resp. 160 MHz channel width. European weather radars are on channels 120 - 130 <https://www.shmu.sk/sk/?page=2037>, hence the full 160 MHz channel width might be problematic, but 80 MHz width fits well without interfering with anything.
    1. Set "Channel width" to "Auto 20/40/80/160" or to "Auto 20/40/80" (prefer 160 if the signal is strong enough, test both).
1. Test the connection speed and stability from multiple rooms in the flat + multiple devices.
