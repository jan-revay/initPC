# WiFi 

## Router config (Huawei HG8145X6 FTTH, single WiFi access point, Orange, Bratislava)

Note: The two most important steps are setting the "Channel width" on 5 GHz WiFi to "Auto 20/40/80" and manually setting the channel to 100. This resolves connectivity issues on 5 GHz WiFi for this router by avoiding DFS channels 120–130, which are used by the Javorník radar and probably also Bratislava Airport radar near Bratislava city (the router is unable to avoid them on auto/default factory settings). The remaining steps are just recommendations.

1. "System tools" tab
    1. Set the root login password for the router's WebGUI. (also prompted on the first login screen)
    1. Turn off led indicators ("Indicator Status Management" -> "Indicator Switch" -> Off).
    1. (Optional) Consider turning off "Enable Energy Saving" ("Advanced Power Management" -> Uncheck "Enable Energy Saving").
1. "WLAN" tab
    1. Set the SSID and password for 2.4 GHz and 5 GHz WiFi. (SSIDs for 2.4 GHz and 5 GHz WiFi should differ, e.g. by -2G resp -5G suffix)
    1. 5G Basic Network Settings
        1. Authentication Mode: WPA3 SAE
    1. 5G Advanced Network Settings:
        1. (IMPORTANT!!!) **Set "Channel width" to "Auto 20/40/80".**
        1. Set the 5GHz **"channel" to fixed 100** (see: <https://en.wikipedia.org/wiki/List_of_WLAN_channels>), if at most than 2 other Access Points are on channels 100-116 (use this Android WiFi analysis tool to check for interference <https://play.google.com/store/apps/details?id=com.vrem.wifianalyzer&pli=1>).
        1. (recommended for smaller apartments - OPTIONAL) Turn off "Band Steering" on 5 GHz WiFi. <https://www.devolo.global/glossary/band-steering>
        1. (recommended) Turn on "Airtime Fairness"
    1. "Wi-Fi Coverage Management" -> "Select a policy to synchronize Wi-Fi parameters to the newly detected external AP." -> "Do not enable automatic synchronization."

## Device config (Android phones, PCs, laptops, ebook readers, smart watches...)

### Smartphones, ebook readers...

1. Only connect to 5GHz WiFi.
2. (in small apartments) Turn off the "Connect automatically" option for 2.4 GHz WiFi.
3. Turn "WiFi scan throttling" in Android Settings -> "Developer options" back on, if I turned it off during WiFi analysis.

### Smartwatches and slower/older WiFi devices

1. Only connect to 2.4 GHz WiFi.
2. Manually check that 5 GHz WiFi is not saved and auto-connect is off for 5 GHz WiFi.
3. Note: Move as many non-critical devices as possible to 2.4 GHz WiFi to improve 5 GHz WiFi reliability. WiFi network is only as quick as the slowest active device on the network, hence mixing quick and slow devices on 5GHz WiFi would be a bad idea.

### Laptops and PCs

1. Laptops and PCs should primarily be connected to the router via an Ethernet cable (ideally shielded CAT6/CAT6A to future-proof). That will also make the WiFi network more stable for mobile devices.
2. Uninstall the "Realtek Dragon utility" if it came preinstalled with the new PC (the driver is buggy and makes the internet connection unreliable).

Finally: Test the connection speed and stability from multiple rooms in the apartment using different devices (ideally at times when neighbors also use WiFi so that the potential interference is detected).


Note: Currently I've measured WiFi speed in all rooms with 2.4GHz and 5GHz WiFi, and 5GHz one is quicker, less congested, and more stable everywhere in the flat (3 room apartment in Petrzalka). Also, the 5GHz connection/signal is disconnected quicker when I leave the house, hence it shortens the glitch while switching to a mobile network (e.g. LTE) when having an online call/meeting and leaving the flat.

## Notes, explanations, and additional materials:

### Basic info

1. <https://www.intel.com/content/www/us/en/support/articles/000058989/wireless/intel-killer-wi-fi-products.html>
2. <https://www.ekahau.com/blog/channel-planning-best-practices-for-better-wi-fi/>
3. <https://support.huawei.com/enterprise/en/doc/EDOC1100143457> (TOREAD)

### Bandwidth & Channel

1. Channel 100 is a good choice because it usually has fewer devices on it than lower, non-DFS channels do and it has enough channels above (channels 100 - 116) for a continuous 80MHz channel width. DFS has roaming issues on multi-AP networks but that is a non-issue when using a single router.
1. Slovak SHMU weather radars are on channels 120 - 130, see: <https://www.shmu.sk/sk/?page=2037> and <https://www.shmu.sk/sk/?page=1566>, hence the full 160 MHz bandwidth on channel 100 is usually unstable in Bratislava, as both the Bratislava Airport and SHMU radar station Malý Javonrík (channels 120-124, 5605 MHz) are in 10km radius. 160 MHz bandwidth would theoretically be also possible on channel 36 but that band has usually a lot of interference from neighboring WiFi routers in apartment buildings. 80 MHz bandwidth on channel 100 usually fits well without interfering and is quick enough for the usual use case (~450Mbps).
1. Due to frequency regulations, it takes around 12 minutes until the Wi-Fi network is available after the router is configured/restarted (because channel 100 and channels around it use the DFS radar avoidance algorithm <https://en.wikipedia.org/wiki/Dynamic_frequency_selection>).
1. If channel 100 is busy (more than 2 access points on it), alternatively channel 36 with 80 Mhz bandwidth, or channel 52 with 80 MHz bandwidth can be used also (not many other options for 80MHz bandwidth with this router). But this would need to be tested during a span of multiple days with <https://www.speedtest.net/>.

### DFS nuances (channels other than 36-48 in SVK)
1. <https://mac-wifi.com/why-i-dislike-dfs-channels-and-you-might-too/>
2. <https://news.ycombinator.com/item?id=34134905>
3. <https://www.reddit.com/r/AmpliFi/comments/ye445i/i_think_i_have_been_killing_my_own_wifi/>
1. <https://www.reddit.com/r/HomeNetworking/comments/18zoroy/best_of_dfs_channels/>
4. <https://metis.fi/en/2017/08/dfs-en/>
5. [DFS - The Untold Story | David Coleman | WLPC Phoenix 2020](https://youtu.be/qCzknrd_F8o?si=QCkyuVTB-NcWA41a)

### Airtime fairness

1. [Wi-Fi 6 Tutorial Series - #13: Band steering, airtime fairness, & lies damn lies](https://youtu.be/FANH5lU5jwI?si=QQBlnhys5HmDKF7d)
