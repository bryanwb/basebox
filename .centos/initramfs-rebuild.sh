# Rebuild the initramfs to ensure
# in includes the right kernel modules:
yum install mkinitrd
rm /boot/initrd-$(uname -r).img
/sbin/mkinitrd --with virtio_pci --with virtio_blk --with virtio_net --with virtio -f /boot/initrd-$(uname -r).img $(uname -r)
