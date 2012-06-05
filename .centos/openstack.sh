#### Cleanup ####
rm -f /etc/udev/rules.d/*persistent-net*
rm -f /lib/udev/rules.d/*persistent-net*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0

#### Metadata ####
cat >/etc/rc.local <<EOF
depmod -a
modprobe acpiphp

# simple attempt to get the user ssh key using the meta-data service
mkdir -p /root/.ssh
echo >> /root/.ssh/authorized_keys
curl -m 10 -s http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key | grep 'ssh-rsa' >> /root/.ssh/authorized_keys
echo "AUTHORIZED_KEYS:"
echo "************************"
cat /root/.ssh/authorized_keys
echo "************************"
EOF
