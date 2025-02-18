#!/bin/bash -eux
uptime
whoami
groups
echo "init"
incus admin init --minimal
echo "git clone"
git clone https://github.com/YunoHost/package_check.git /home/yunohost/package_check
echo "package check"
