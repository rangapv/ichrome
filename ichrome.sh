#! /bin/bash
li=$(uname -s)
li2="${li,,}"

u1=$(cat /etc/*-release | grep ubuntu)
f1=$(cat /etc/*-release | grep ID= | grep fedora)
c1=$(cat /etc/*-release | grep ID= | grep centos)
s1=$(cat /etc/*-release | grep suse)


if [ ! -z "$u1" ]
then 
	mi=$(lsb_release -cs)
	mi2="${mi,,}"
	ji=$(cat /etc/*-release | grep DISTRIB_ID | awk '{split($0,a,"=");print a[2]}')
	ki="${ji,,}"

	if [ "$ki" == "ubuntu" ]
	then
   	echo "IT IS UBUNTU"
	fi
        sudo apt-get -y update
        sudo apt-get install -y wget
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
        sudo apt-get -y update
        sudo apt-get -f install
        sudo apt-get install -y google-chrome-stable
	ln -sf /usr/bin/google-chrome-stable $HOME/chrome

fi


if [ ! -z "$f1" ]
then
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"=");print a[2]}')
        ki="${ji,,}"
fi

if [ ! -z "$c1" ]
then
	echo "IT IS CENTOS"
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
	sudo yum install -y  wget
	sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
	sudo yum install -y ./google-chrome-stable_current_*.rpm
	ln -sf /usr/bin/google-chrome-stable ./chrome
	echo " " >> ~/.bashrc
	echo "export PATH=$PATH:$PWD/chrome" >> ~/.bashrc
fi
