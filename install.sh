#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be executed as root" >&2
	exit 1
fi

echo -e "It is highly recommended to run this script from chroot to avoid system crash in the middle of the process.\nThis script will wipe directories /var/rc/ and /etc/rc/ if you have these."
read -p "Continue running the script? (y/N) " response

if [ "$response" != "y" ]
then
    exit 1
fi

echo;
echo " -< Copying services... >-"
rm -rf /var/rc &> /dev/null
mkdir /var/rc
cp -rv ./var/rc /var/

echo;
echo " -< Making symlinks... >-"
rm -rf /etc/rc &> /dev/null
mkdir /etc/rc
ln -sv /var/rc/* /etc/rc/

echo;
echo " -< Creating reserve copies of important files... >-"
files=("shutdown" "reboot" "poweroff")
for file in "${files[@]}"
do
  filename=$(basename "$file")
  mv -v /sbin/"$file" /sbin/"$file-old"
done

echo;
echo " -< Copying rc.init and rc.shutdown... >-"
cp -v ./bin/* /bin/

echo;
echo " -< Copying shutdown script and making symlinks... >-"
cp -v ./sbin/* /sbin/
ln -sv /sbin/shutdown /sbin/reboot
ln -sv /sbin/shutdown /sbin/poweroff

echo;
echo " -< Installing suckless init as default... >-"
mv -v /sbin/init /sbin/init-old
cp -v /usr/local/bin/sinit /sbin/sinit
cp -v /sbin/sinit /sbin/init

if [ $? -eq 0 ]; then
	echo;
	echo " -< Succeeded. Now you can reboot >-"
fi
