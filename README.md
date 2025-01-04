# Stop Sauron

:red_circle: `Last update 4 january 2025`

To stop the all seeing eye of Sauron and make your MacBook operate as it should be.

This bash script has been created to harmless disable/enable software being pushed to your MacBooks by a Mobile Device Management (MDM) system.
Unfortunate you still need to have `sudo` rights, but when that's the case you can easily on demand disable/enable the following software packages:

1. WorkSpace One (WS1) (AirWatch)
2. FireEye XAGT agent(s)
3. McAfee
4. Zscaler
5. CylancePROTECT
6. CrowdStrike Falcon
7. Rabit7 agent

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
|  | Sonoma (14.0 - 14.7.2) | :white_check_mark: |
|  | Sequoia (15.0 -15.2) | :white_check_mark: |
| WorkSpace 1 | 20.10.0 - 24.07.2 | :white_check_mark: |
| FireEye | 33.22.6 | :white_check_mark: |
| McAfee Endpoint Security for Mac | 10.7.8 (186) | :small_red_triangle_down: |
| McAfee Threat Prevention | 10.7.8 (128) | :white_check_mark: |
| McAfee Firewall | 10.7.8 (115) | :white_check_mark: |
| Zscaler | 2.1.2.38 - 4.3.0.237 | :white_check_mark: |
| Cylance | 2.1.1594.518 - 3.0.1000.511 | :white_check_mark: |
| Crowdstrike Falcon | ? | :x: |
| Rabit7 | 4.0.13.32 | :question: |

This sh script is written for GNU bash version 3.2.*, which is the current used version for OSX & MacOS and has been since the first release of OSX Lion.

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
