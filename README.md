# Stop Sauron
To stop the all seeing eye of Sauron and make your MacBook operate as it should be.

This bash script has been created to harmless disable/enable software being pushed to your MacBooks by a Mobile Device Management (MDM) system.
Unforunate you still need to have `sudo` rights, but when that's the case you can easily on demand disable/enable the following software packages:

1. WorkSpace One (WS1) (Airwatch)
2. FireEye XAGT agent(s)
3. McAfee 


## USE AT OWN RISK


## Usage
Make the script executable
```
$ chmod +x ./stop-sauron.sh
```
Run the script as sudo
```
$ sudo ./stop-sauron.sh
```
Select you demanded action out of the options

* Option 1: for disabling 
* Option 2: for enabling
* Option 3: cancel & quit


## Compatibility

| Packages | Version compatibility |
| --- | --- |
| macOS | Big Sur (11.0.1 - 11.1) |
| WorkSpace 1 | 20.10 |
| FireEye | 33.22.6 |
| McAfee | 10.7.5 (266) |


## Future plans
Adding more packages that harm your development & work velocity or personal privacy
