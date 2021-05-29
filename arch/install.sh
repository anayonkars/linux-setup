#!/bin/sh
set -x
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mount /dev/sda1 /mnt
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone Asia/Kolkata
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo archvbox > /etc/hostname
echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.0.1		archvbox" >> /etc/hosts
pacman -S grub plasma kde-applications sudo konsole sddm networkmanager --noconfirm
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable sddm.service
systemctl enable NetworkManager.service
useradd -m -G users anayonkar
echo "anayonkar ALL=(ALL) ALL"
passwd
passwd anayonkar