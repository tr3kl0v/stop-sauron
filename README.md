# Stop Sauron

** :red_circle: `<important notification>` :red_circle: ** 

If you're currently using a version from before 14-01-2023, please enable stop-sauron first before updating to the latest version. There is a breaking change in the way enable/disable is handled.

** :red_circle: `<important notification/>` :red_circle: ** 

To stop the all seeing eye of Sauron and make your MacBook operate as it should be.

This bash script has been created to harmless disable/enable software being pushed to your MacBooks by a Mobile Device Management (MDM) system.
Unfortunate you still need to have `sudo` rights, but when that's the case you can easily on demand disable/enable the following software packages:

1. WorkSpace One (WS1) (AirWatch)
2. FireEye XAGT agent(s)
3. McAfee
4. Zscaler
5. CylancePROTECT
6. CrowdStrike Falcon

## Usage

Use at your own risk, but know I'm continuously using it on daily basis. I dying this great power ;-)

Make the script executable:

```zsh
chmod +x ./stop-sauron.sh

```

Run stop Sauron as sudo:

```zsh
sudo ./stop-sauron.sh

```

Select you demanded action out of the options

* Option 1: Stop Sauron's eye (for disabling)
* Option 2: Start Sauron's eye (for enabling)
* Option 3: Clean the logs (Clean the debug logfiles create with the -x flag)
* Option 4: Remove the config (Removing the original configuration files, create on the first run)
* Option 5: Create lifesaver (Creating a backupfile of the configuration files)
* Option 6: Exit (without any actions)


## Compatibility

Stop Sauron supports the software packages mentioned in the table below on OSX. The test column can have several states. The :white_check_mark: means :100:% tested on the complete software package and the :small_red_triangle_down: means tested, but not on all software packages options. For example McAfee has many options like a web-firewall, threat prevention, etc. The :heavy_check_mark: means that according to a variant of sources, e.g. documentation `$ man launchctl`, the functions should work, but is not yet tested. The :x: means it does not work.

| Packages | Version | Tested |
| :--- | :--- | ---: |
| MacOS | Snow Leopard (10.6 - 10.6.8) | :heavy_check_mark: |
|  | Lion (10.7 - 10.7.5) | :heavy_check_mark: |
|  | Mountain Lion (10.8 - 10.8.5) | :heavy_check_mark: |
|  | Mavericks (10.9 - 10.9.5) | :heavy_check_mark: |
|  | Yosemite (10.10 - 10.10.5) | :white_check_mark: |
|  | El Capitan (10.11 - 10.11.6) | :white_check_mark: |
|  | Sierra (10.12 - 10.12.6) | :white_check_mark: |
|  | High Sierra (10.13 - 10.13.6) | :white_check_mark: |
|  | Mojave (10.14 - 10.14.6) | :white_check_mark: |
|  | Catalina (10.15 - 10.15.7) | :white_check_mark: |
|  | Big Sur (11.0.1 - 11.3.1) | :white_check_mark: |
|  | Monterey (12.0 - 12.6) | :white_check_mark: |
|  | Ventura (13.0 - 13.1) | :white_check_mark: |
| WorkSpace 1 | (20.10.0 - 22.01.0 | :white_check_mark: |
| FireEye | 33.22.6 | :white_check_mark: |
| McAfee Endpoint Security for Mac | 10.7.8 (186) | :small_red_triangle_down: |
| McAfee Threat Prevention | 10.7.8 (128) | :white_check_mark: |
| McAfee Firewall | 10.7.8 (115) | :white_check_mark: |
| Zscaler | 2.1.2.38 | :white_check_mark: |
| Cylance | 2.1.1594.518 - 3.0.1000.511 | :white_check_mark: |
| Crowdstrike Falcon | ? - ? | :heavy_check_mark:|

This sh script is written for GNU bash version 3.2.*, which is the current used version for OSX & MacOS and has been since the first release of OSX Lion.


## Restoring machine state in case of emergency

It could potential happen that services have changed, enabling  deamons/agents doesn't work anymore or stop-sauron is failing at all. This happend to me once after releasing version 1.1.4 of the script. 
Hereby I want to provide you an in case of emergency recovery method. The first step is that you need to know that there are 2 configuration files generated on the first run. If you're smart you've created a lifesaver. This will mean you'll have 2 or 4 (with lifesaver) configuration files in the folder from where you run the script. There is 1 deamons and 1 agents configuration files. With lifesaver two of each.
All configuration files have a timestamp of creation. The second step is to evaluate which configuration file is most suitable to do the recovery from. It could be the oldest, but it could also be the newest.
Pick 1 set of the configuration files. With 1 set I mean or the conf files or the backup files. Step 3 is to run the commands below one by one for each entry in the configuration files.

For enabling deamons use:

```zsh
$ sudo launchctl load -w /Library/LaunchDaemons/com.xxx.xxx.plist

```

For enabling agents use:

```zsh
$ launchctl load -w /Library/LaunchAgents/com.xxx.xxx.plist

```
After you're done you have restored your machine to the original state before using stop-sauron. Be careful not to wait forever with making new conf files or backups. Your security department makes changes all the time. 


## Future plans

Adding more packages that harm your development & work velocity or personal privacy

## Contributing

Contributing is very appreciated, because it is not easy to have licensed access to all enterprise security tools out there on the planet.
When you want to do development yourself have a look at the development [readme](https://github.com/tr3kl0v/stop-sauron/blob/main/development/DEVELOPMENT.md).

### Want to Help?

Want to file a bug, contribute some code, or improve documentation? Excellent!  
Please run stop-sauron with the `-x` flag and submit the generated `debug.log` always in your ticket.  
Feel free to create an issue and submit all you think will help.

### Appendix

View [appendix](https://github.com/tr3kl0v/stop-sauron/blob/main/APPENDIX.md) for references and sources for ideas.

### Disclaimer

No liability for the contents of this documents can be accepted. Use the concepts, examples and other content at your own risk. There may be errors and inaccuracies, that may of course be damaging to your system. Although this is highly unlikely, you should proceed with caution. The author does not accept any responsibility for any damage incurred.

All copyrights are held by their respective owners, unless specifically noted otherwise. Use of a term in this document should not be regarded as affecting the validity of any trademark or service mark.

Naming of particular products or brands should not be seen as endorsements.
