#!/bin/bash -eux

# Add yunohost user to sudoers.
echo "yunohost        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
