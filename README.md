# Pisces QoL Dashboard #

This is a replacement dashboard for the Pisces Helium Miner.

The dashboard that ships with the Pisces P100D has a number of security and performance issues.  The main things this dashboard fixes are:
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
2. Use the following two link, replacing __YOURIP__ with the IP address of your miner:
  - http://__YOURIP__/action.php?action=shell&cmd=sudo wget https://raw.githubusercontent.com/briffy/PiscesQoLDashboard/main/install.sh | bash
3. Log in at https://__YOURIP__
  - Username: admin
  - Password: admin
4. Click "Tools"
5. Click "Reset Password"
6. Enter a secure password and click submit.
7. Enjoy!


## Removal Instructions ##

1. Connect via SSH to your miner (either using PuTTY or open cmd and type:  ssh admin@YOURIP)
2. Enter the admin username and the password you set.
3. Type the following command:  sudo bash /var/dashboard/uninstall.sh
