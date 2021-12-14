#!/bin/bash

locate --version &> /dev/null
if [ $? -ne 0 ]; then
        echo
        printf "\e[1m\e[31mPlease install 'locate' before execute this script\e[39m\n"
        printf "Install example (Debian): \e[34mapt install mlocate\e[39m\e[21m\n"
        printf "Install example (Fedora): \e[34mdnf install mlocate\e[39m\e[21m\n"
        echo
        exit
fi

echo
printf "[*] Updating locate cache...\n"
echo

updatedb

echo
printf "[*] Searching in locate cache...\n"
echo

LOCATE_RESULT="$(locate log4j|grep -v log4js)"
if [ "$LOCATE_RESULT" ]
then
	printf "[-] Check if these files can be vulnerable:\n"
	echo "$LOCATE_RESULT"
else
	printf "[+] OK, seems not vulnerable files\n"
fi

echo
printf "[*] Searching in dpkg installed packages...\n"
echo

DPKG_RESULT="$(dpkg -l|grep log4j|grep -v log4js)"
if [ "$DPKG_RESULT" ]
then
	printf "[-] Check if these dpkg installed packages can be vulnerable:\n"
	echo "$DPKG_RESULT"
else
	printf "[+] OK, seems not vulnerable packages\n"
fi

echo
printf "[*] NOTE: This test are not 100%% reliable, but it helps for quick scan.\n"
echo
