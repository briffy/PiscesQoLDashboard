# Pisces QoL Dashboard #

This is a replacement dashboard for the Pisces Helium Miner.

The dashboard that ships with the Pisces P100 has a number of security and performance issues.  The main things this dashboard fixes are:
* Lack of any authentication on the frontend.
* Removal of ability to run root level code from the web server.
* Changes to the way data is polled so that the dashboard doesn't hang for ~30 seconds while waiting for GPS/Bluetooth/Helium miner to report back statuses.
* Enabling of WiFi support (not tested with mining).


## Important Notes ##

This dashboard is in no way supported by, or affiliated with, the Pisces dev team.

By installing this dashboard, you are inheritently making the device more secure by removing the device's ability to install things like this dashboard from the web server.  

A result of this is that in the event you need to troubleshoot your device, Pisces will have one fewer tool to assist you (although arguably this should never have been a tool for them to use in the first place).  I have taken steps to avoid this so please read the important information below:

Installing this script creates a __sudo user__ called "__admin__" with the password "__admin__".  When you first log in to the dashboard, __it is imperative that you visit Tools > Reset Password and update this password.__


## Installation Instructions ##

1. Find the internal IP address of your Pisces miner.
2. Use the following link, replacing __YOURIP__ with the IP address of your miner:
  - http://__YOURIP__/action.php?action=shell&cmd=wget https://raw.githubusercontent.com/briffy/PiscesQoLDashboard/main/install.sh -O - | sudo bash
3. Log in at https://__YOURIP__
  - Username: admin
  - Password: admin
4. Click "Tools"
5. Click "Reset Password"
6. Enter a secure password and click submit.
7. Enjoy!


## Updating ##

As of v0.1.1, the dashboard now has an updater.  If you are running version v0.1.0 then you will have to manually update this one.  Follow the instructions below:

1. Log in via SSH (either PuTTY or click start > type "cmd" and press enter, then type "ssh admin@your-miner-ip").
2. Run the following commands:
   - wget https://raw.githubusercontent.com/briffy/PiscesQoLDashboard/main/update.sh -O - | sudo bash

## Removal Instructions ##

1. Connect via SSH to your miner (either using PuTTY or open cmd and type:  ssh admin@YOURIP)
2. Enter the admin username and the password you set.
3. Type the following command:  sudo bash /var/dashboard/uninstall.sh


## Caveats ##

* It's not using jQuery or anything fancy to pull statuses on stuff.  If you click a button to enable/disable a service, manually refresh a few times until it updates.
* You will likely get a "This site is not secure" banner when you first connect.  This is because I've enabled HTTPS by default with a self-signed certificate.  The reason it is "not secure" is because web browsers prefer certificates to be signed by an authority, not just yourself.  I promise though, HTTPS with a self-signed certificate is way more secure than standard HTTP (don't take my word for it, Google "https vs http") because at least your data is being encrypted this way.  If you care enough, go buy a certificate for a couple of bucks and add it into /etc/ssl/  (you've got root access now).


## Change Log ##
- v0.2.6
  * Very very minor bug fix to the VPN display status.
- v0.2.5
  * Added VPN support for all you off-grid setups and people on CGNAT.
- v0.2.4
  * Fixed bug introduced in previous release that would lock the miner update to the latest non GA version.

- v0.2.3
  * Actually put ALL the fixes in from the previous update this time...
  
- v0.2.2
  * Potential fix for miner height not displaying correctly and causing it to show as perpetually syncing (thanks to fraggy2k).
  * Modified witness log output to better capture the full witness event.
  * Added uptime to the home screen.
  
- v0.2.1
  * Removed seed connector from the auto-maintain script.  Seems more and more like a Helium issue every day and no amount of smashing is going to fix it (https://github.com/helium/miner/issues/1205)
  * Fixed faulty logic with sync checker.
  * Split auto-maintain and auto-update into separate functions.
  * Removed an option in the miner update that may cause problems for the US based miners that are starting to appear.
  
- v0.2.0
  * Added a seed node smasher into the automaintain.  This digs and connects to the Helium seed nodes every hour, hopefully help with low activity on the blockchain.  Or it'll DDoS the seed nodes.  Let's find out.
  * Changed the sync status script to be less sensitive (THANKS SHRYKEZ).
  * Modified the blockchain clear to check for any status other than "Up" instead of specifically looking for the "exited" status.
  * Changed log files to be in reverse order.
  
- v0.1.9
  * Added a "Logs" section.
  * Modified the miner update docker run command to add region override and change the port bindings to try and alleviate low beacon/challenge issues, **running a miner update is recommended.**
  * Merged Shrykez sync checker.
 
- v0.1.8
  * Fixed the FastSync button.
  * Added an "AutoMaintain" option.  Enable the spanner in the services menu and now miner/dashboard updates will be taken care of.  It will also automatically try and keep track of your block height and perform a fast sync if you drift too much, as well as doing basic troubleshooting steps when it detects problems with your miner docker.

- v0.1.7
  * Fixed the dashboard updater so it doesn't nuke the logs during update and avoids any caching issues.
 
- v0.1.6
  * Fixed possible bug with "\_GA" being appended to the version string.
  
- v0.1.5
  * Minor quality of life fixes.
  * Updated to use wget instead of curl to avoid DDoS issues with Helium API.
  * Changed miner updater to pull the latest sys config from this github (updated from Helium miner gitgub and modified for use with the Pisces:https://github.com/helium/miner/blob/master/config/sys.config) 

- v0.1.4
  * If the miner docker has already locked up due to blockchain corruption then docker stop isn't aggressive enough to stop it.  This has been changed to docker kill and I have also changed the method for removing the files as when it grows past a certain point, rm cannot deal with it in one hit.

- v0.1.3
  * Changed the miner updater to pull only the latest GA versions (https://en.wikipedia.org/wiki/Software_release_life_cycle#General_availability_(GA))

- v0.1.2
  * Fixed bug with docker updater.  If no config has been downloaded by Pisces (either updates disabled or haven't run) then it would stop the docker from being enabled.  Now it will use the current config if no new config from Pisces is found.

- v0.1.1
  * Added functionality: clear blockchain data, update miner docker and update dashboard.
  * A few quality of life enhancements, tweaking of minor bugs and updating styles.
  * Merged fix for remote IP lookup.

## Buy me a beer ##

If you like my work, sling me some crypto:

* ETH: 0x5130357514BA058a78855E9A6B071E0E91e39aCd
* HNT: 13eyzqK1Dqqnj2dBHxBoWhbnGcdA7ZWh9kpejg4MTE6QzdRMU9p
