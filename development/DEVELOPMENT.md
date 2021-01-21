# Development

To enable you doing development the scripts we creates some supporting tools / setting to make your life easier.

## Tools to install

| Tool | Used for |
| --- | --- |
| iTerm2 | iTerm2 is a terminal emulator that does great things |
| Brew | This is our preferred Package Manager for macOS |
| iTermocil | iTermocil allows you to setup pre-configured layouts of windows and panes in iTerm2, having each open in a specified directory and execute specified commands |

## Installing the tools

### Installing iTerm2

Download the [installer](https://iterm2.com/downloads/stable/latest) and install iTerm2.
Further information about iTerm2 can be found [here](https://iterm2.com).

### Installing Brew

```bash
# Install Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

```

Further information about Brew can be found [here](https://brew.sh/).

### Installing iTermocil

```bash
# Install `itermocil` via Homebrew
$ brew update
$ brew install TomAnthony/brews/itermocil

# Create your layout directory
$ mkdir ~/.itermocil

# add Zsh autocompletion
# To get autocompletion when typing itermocil <Tab> in a zsh session, add this line to your ~/.zshrc file:
$ compctl -g '~/.itermocil/*(:t:r)' itermocil

```

Further information about iTermocil can be found [here](https://github.com/TomAnthony/itermocil).

## Scripts and settings

Here you can find/download the scripts or settings used during development

### Copy iTermocil configuration file

Copy the following [file](https://github.com/tr3kl0v/stop-sauron/blob/main/development/stop-sauron_development-panes.yml) to the iTermocil config folder.

```bash
# copy iTermocil config
$ cp ~/Workspace/stop-sauron/development/stop-sauron_development-panes.yml ~/.itermocil/stop-sauron_development-panes.yml

```

You can start the development views simply by executing;

```bash
# start views
$ itermocil stop-sauron_development-panes

```

## Downloading and creating VMWare images to develop & test against

It is obvious that you shouldn't test against your primary installation of the MacOs. True, there will be a moment, that you must gamble and try it out, but this risk will be less if you're pretty sure the tests survived on a VMWare image.

| MacOS version | Download link / method | Method to create VMWare image* |
| --- | --- | --- |
| Snow Leopard - 10.6.8 |  [archive.org](https://archive.org/details/SnowLeopardInstall) | TBD |
| Lion - 10.7.5 | [archive.org](https://archive.org/details/mac-os-x-10.7.5) | TBD |
| Mountain Lion - 10.8.5 | [AllMacworld.com](https://allmacworld.com/mac-os-x-mountain-lion-10-8-5-free-download/) | TBD |
| Mavericks - 10.9.5 | [AllMacworld.com](https://allmacworld.com/mac-os-x-mavericks-10-9-5-free-download/) | TBD |
| El Capitan - 10.11.6 | [Apple CDN link](http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg) |  2 |
| Sierra - 10.12.6 | [Apple CDN link](http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg) |  2 |
| High Sierra - 10.13.6 | [Apple Store link](https://apps.apple.com/us/app/macos-high-sierra/id1246284741?ls=1&mt=12) | TBD |
| Mojave - 10.14.6 | [Apple Store link](https://apps.apple.com/gb/app/macos-mojave/id1398502828?mt=12) | 1 |
| Catalina - 10.15.7 | [Apple Store link](https://apps.apple.com/sg/app/macos-catalina/id1466841314?mt=12) | 1 |
| Big Sur - 11.1 | [Apple Store link](https://apps.apple.com/us/app/macos-big-sur/id1526878132?mt=12) | 1 |

* Download links are provided as is. Please let me know when a link is dead

### Method 1 --  Create a bootable installer for macOS

#### What you need to create a bootable installer

A USB flash drive or other secondary volume, formatted as Mac OS Extended, with at least 12GB of available storage. A downloaded installer for macOS Big Sur, Catalina, Mojave, High Sierra, or El Capitan

#### Use the 'createinstallmedia' command in Terminal

* Connect the USB flash drive or other volume that you're using for the bootable installer. 
* Open iTerm, which is in the Utilities folder of your Applications folder.
* Type or paste one of the following commands in iTerm. These assume that the installer is in your `Applications` folder, and `MyVolume` is the name of the USB flash drive or other volume you're using. If it has a different name, replace `MyVolume` in these commands with the name of your volume.

Big Sur:*

```bash
# Create bootable disk
$ sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

```

Catalina:*

```bash
# Create bootable disk
$ sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

Mojave:*

```bash
# Create bootable disk
$ sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

```

High Sierra:*

```bash
# Create bootable disk
$ sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

El Capitan:

```bash
# Create bootable disk
$ sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app
```

* If your Mac is using macOS Sierra or earlier, include the --applicationpath argument and installer path, similar to the way this is done in the command for El Capitan.

After typing the command:

1. Press Return to enter the command.
2. When prompted, type your administrator password and press Return again. Terminal doesn't show any characters as you type your password.
3. When prompted, type Y to confirm that you want to erase the volume, then press Return. Terminal shows the progress as the volume is erased.
4. After the volume is erased, you may see an alert that Terminal would like to access files on a removable volume. Click OK to allow the copy to proceed. 
5. When Terminal says that it's done, the volume will have the same name as the installer you downloaded, such as Install macOS Big Sur. You can now quit Terminal and eject the volume.

#### Create the VMware image

Open VMware Fusion create a new VM.

1. Go to "File > New"
2. Select "Install from disc of image"
3. Go your just created USB disk and select e.g. "Install macOS Catalina.app"
4. Press "Open"
5. Press "Continue"
6. VMWare has detected the correct guest operating system as MacOs 10.15 in this example and provided specs for the VM. You just can continue with the creation by pressing "Finish".

Your VM will now be created and it takes normally between 15 ~ 45 minutes to finish. After the installation of MacOs don't forget to install the VMware tools to ease the interaction between your host and guest system.
### Method 2 --  Create a bootable installer for macOS

Method is two is slightly different because it is a workaround to get an older version of MacOS working.

If you have a Mac which is too new to run Yosemite, El Capitan or Sierra and no access to an older Mac, then the following process works.

1. Download the full installer for the version of macOS that your Mac is currently running or is able to run (High Sierra, Mojave, Catalina or BigSur). The normal method via App Store gives you an installer application in your /Applications folder.
2. Use that installer application to create a VM and set it up. Install VMware Tools for convenience.
3. From inside the VM, open the .dmg file for the Yosemite, El Capitan or Sierra installer, and open the package. The installer recognizes it is running in a VM and bypasses the model check, so it will create an installer application for the target version in the VMs Applications folder.
4. Copy the installer application for the older OS back to the host.
5. Use the installer application for the older OS to create a VM for the version you want.

During the installation of the older versions of MacOS X, you'll get notification that the keyboard & mouse are not working in e.g. Yosemite. and to fix that you need to shut down the virtual machine and going into its *Settings* and choosing *USB & Bluetooth*, then expand *Advanced USB options* and set the *USB Compatibility* option to *USB 2.0* or lower.  Boot up the VM and the guest OS will be able to use the keyboard and mouse.
