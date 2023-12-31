# sinit-scripts

Collection of services for [suckless init](https://core.suckless.org/sinit/) with [daemontools-encore](http://untroubled.org/daemontools-encore/) process manager and [LittKit](http://troubleshooters.com/projects/littkit/) for process ordering. Tested on Artix Linux, but can probably work on other distros.

Insipired by [this](http://troubleshooters.com/linux/diy/suckless_init_on_plop.htm) guide.

![megainit](./stuff/artix-sinit.png)

## How it works?

1. Kernel executes `sinit` (suckless init).
2. `sinit` executes `/bin/rc.init`.
3. `/bin/rc.init` does some important stuff with pseudo filesystems and executes services in `/etc/rc/`.
4. `dtinit` (daemontools init) is the first service to start in `/etc/rc/` and it executes other services in `/etc/rc/` in proper order using LittKit's `lk_runsvc`.

## Adding new services
```bash
mkdir /var/rc/service_name
touch /var/rc/service_name/run # main execution script for the service. Note: daemontools-encore is going to restart the service every time it finishes execution of the run file. I you want to avoid this add "lk_forever 3600" at the end of the script.
chmod u+x /var/rc/service_name/run
ln -s /var/rc/service_name /etc/rc/
# Add "log 'service_name'" (optionally) and "lk_runsvc /etc/rc/service_name 0" to /etc/rc/dtinit/dtinit.sh 
```

## Installation
First of all, clone, the repo:
```bash
git clone https://github.com/Andrey0189/sinit-scripts
cd sinit-scripts/
```
Then you need to install suckless init, daemontools-encore and LittKit. You can do it automatically using file `install-deps.sh`, but doing it manually is safer, if for example, you get an error during compilation.
```bash
# sinit
git clone https://git.suckless.org/sinit
cd sinit/
make
sudo make install
```
```bash
# daemontools-encore
git clone https://github.com/bruceg/daemontools-encore
cd daemontools-encore/
./makemake
make
sudo make install
```
```bash
# LittKit
curl -o littkit.tgz http://troubleshooters.com/projects/littkit/downloads/littkit_0_90.tgz
tar xvf littkit.tgz
cd littkit_0_90
sudo cp lk_* /usr/local/bin 
```
\
**I highly recommend performing the next instructions from chroot via some livecd. You can try to do this on working machine, but chroot is much safer.**


After you installed these dependencies, you can run the installation script for services, that will replace your current init with suckless init.
```bash
# Assuming you are doing it from chroot
./install.sh
exit
umount -R /mnt
reboot
```
If everything was done correctly, you can finally boot into your system with the suckless init!

## Possible issues
* `/bin/rc.shutdown` is a little bit problematic and doesn't unmount filesystems properly on every shut down, which possibly may lead to filesystem damage. To be fixed soon.

Currently only tested on these distos:

- Artix
- Arch

Works perfectly on Artix, but on Arch you need to install elogind. If it works on your distro, let me know in pull requests. 

***
