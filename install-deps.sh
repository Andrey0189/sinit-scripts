#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be executed as root" >&2
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git." >&2
    exit 1
fi

echo;
echo " -< INSTALLING SINIT >-"
git clone https://git.suckless.org/sinit
cd sinit/
make
make install
cd ..

echo;
echo " -< INSTALLING DAEMONTOOLS-ENCORE >-"
git clone https://github.com/bruceg/daemontools-encore
cd daemontools-encore/
./makemake
make
make install
cd ..

echo;
echo " -< INSTALLING LITTKIT >-"
curl -o littkit.tgz http://troubleshooters.com/projects/littkit/downloads/littkit_0_90.tgz
tar xvf littkit.tgz
cd littkit_0_90
cp -v lk_* /usr/local/bin 
cd ..

if [ $? -eq 0 ]; then
	echo;
	echo " -< Succeeded >-"
fi
