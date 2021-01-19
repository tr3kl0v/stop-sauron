# Stop Sauron

To stop the all seeing eye of Sauron and make your MacBook operate as it should be.

This bash script has been created to harmless disable/enable software being pushed to your MacBooks by a Mobile Device Management (MDM) system.
Unfortunate you still need to have `sudo` rights, but when that's the case you can easily on demand disable/enable the following software packages:

1. WorkSpace One (WS1) (Airwatch)
2. FireEye XAGT agent(s)
3. McAfee
4. Zscaler

## Usage

Use at your own risk, but know I'm using it quite often.

Make the script executable:

```zsh
chmod +x ./stop-sauron.sh

```

Run stop Sauron as sudo:

```zsh
sudo ./stop-sauron.sh

```

Select you demanded action out of the options

* Option 1: for disabling
* Option 2: for enabling
* Option 3: cancel & quit

## Compatibility

| Packages | Version compatibility |
| --- | --- |
| MacOS | Snow Leopard (10.6 - 10.6.8)<br> Lion (10.7 - 10.7.5)<br> Mountain Lion (10.8 - 10.8.5)<br> Mavericks (10.9 - 10.9.5)<br> Yosemite (10.10 - 10.10.5)<br> El Capitan (10.11 - 10.11.6)<br>  Sierra (10.12 - 10.12.6)<br> High Sierra (10.13 - 10.13.6)<br> Mojave (10.14 - 10.14.6)<br> Catalina (10.15 - 10.15.7)<br>  Big Sur (11.0.1 - 11.1) |
| WorkSpace 1 | 20.10 |
| FireEye | 33.22.6 |
| McAfee | 10.7.5 (266) |
| Zscaler | 2.1.2.38 |

## Future plans

Adding more packages that harm your development & work velocity or personal privacy

## Contributing

Contributing is very appreciated, because it is not easy to have licensed access to all enterprise security tools out there on the planet.
When you want to do development yourself have a look at the development [readme](https://github.com/tr3kl0v/stop-sauron/blob/main/development/DEVELOPMENT.md).

### Want to Help?

Want to file a bug, contribute some code, or improve documentation? Excellent!
Feel free to create an issue and submit all you think will help.

### Disclaimer

No liability for the contents of this documents can be accepted. Use the concepts, examples and other content at your own risk. There may be errors and inaccuracies, that may of course be damaging to your system. Although this is highly unlikely, you should proceed with caution. The author does not accept any responsibility for any damage incurred.

All copyrights are held by their respective owners, unless specifically noted otherwise. Use of a term in this document should not be regarded as affecting the validity of any trademark or service mark.

Naming of particular products or brands should not be seen as endorsements.
