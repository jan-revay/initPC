# WiFi 

## TODO - this did not help - Samsung Galaxy is still dropping the 5GHz network...

## Router config (Huawei HG8145X6 FTTH, Orange)

1. "WLAN" tab
    1. Set SSID and PW on 2.4 GHz and 5 GHz WiFI.
1. "System tools" tab
    1. Set the root login password for the router's WebGUI.
    1. Turn off led indicators ("Indicator Status Management" -> "Indicator Switch" -> Off).
    1. Turn off "Enable Energy Saving" ("Advanced power management" -> "Enable Energy Saving" - uncheck).
1. 5G Basic Network Settings
    1. Authentication Mode: WPA3 SAE
1. 5G Advanced Network Settings:
    1. Turn off "Band Steering" on 5 GHz WiFi. <https://www.devolo.global/glossary/band-steering>
    1. Set the 5GHz "channel" to fixed **100** (see: <https://en.wikipedia.org/wiki/List_of_WLAN_channels>) if it is not interfering with a neighbor's WiFI (use Android WiFi analysis tools to investigate).
        1. Note1: Channel 100 is a good choice because it has fewer devices on it as lower channels do and it has enough space for a continuous 80MHz resp. 160 MHz channel width. European weather radars are on channels 120 - 130 <https://www.shmu.sk/sk/?page=2037>, hence the full 160 MHz channel width might be problematic, but 80 MHz width fits well without interfering.
        1. Note2: Due to frequency regulation, it takes around 12 minutes until the Wi-Fi network is available after the router is restarted (because channel 100 and channels around it use the DFS algorithm https://en.wikipedia.org/wiki/Dynamic_frequency_selection).
        1. <https://www.reddit.com/r/HomeNetworking/comments/18zoroy/best_of_dfs_channels/> 
    1. Set "Channel width" to "Auto 20/40/80/160" or to "Auto 20/40/80" (prefer 160 if the signal is strong enough, test both).
    1. "Wi-Fi Coverage Management" -> "Select a policy to synchronize Wi-Fi parameters to the newly detected external AP." -> "Do not enable automatic synchronization." (TODO this is probably not necessary)
1. Test the connection speed and stability from multiple rooms in the flat + multiple devices.

## Device config (Android phones, PCs, laptops, ebook readers, smart watches...)

1. Only connect to 5GHz WiFi.
2. Forget the password to 2.4 GHz WiFi on all devices if I used the 2.4GHz band before.
3. Turn "WiFi scan throttling" in Android Settings -> "Developer options" back on, if I turned it off during testing.
4. Test the connection speed on all devices in multiple rooms of the flat.

Note: Currently I've measured the speeds in all rooms with 2.4GHz and 5GHz WiFi, and 5GHz one is quicker, less congested and more stable everywhere in the flat. Also, the 5GHz connection/signal is lost quicker when I leave the house hence it shortens the glitch while switching to a mobile network (e.g. LTE).

## TODO - toread:

1. <https://mac-wifi.com/why-i-dislike-dfs-channels-and-you-might-too/>
2. <https://news.ycombinator.com/item?id=34134905>
3. <https://www.reddit.com/r/AmpliFi/comments/ye445i/i_think_i_have_been_killing_my_own_wifi/>
4. <https://metis.fi/en/2017/08/dfs-en/>
5. <https://www.ekahau.com/blog/channel-planning-best-practices-for-better-wi-fi/>
6. ... consider using classic, non-DFS channels?
