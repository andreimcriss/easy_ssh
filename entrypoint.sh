#!/bin/sh

while getopts u:p: OPT
do
  case $OPT in
    "u" ) LOGIN_USER="$OPTARG" ;;
    "p" ) LOGIN_PASS="$OPTARG" ;;
  esac
done

if [ "$LOGIN_USER" != "" -a "$LOGIN_PASS" != "" ]; then
  adduser --disabled-password --gecos "" $LOGIN_USER
  gpasswd -a $LOGIN_USER sudo
  echo "$LOGIN_USER:$LOGIN_PASS" | chpasswd
  echo "root:$LOGIN_PASS" | chpasswd
fi

/usr/sbin/sshd -D
