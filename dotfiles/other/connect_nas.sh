sudo apt install nfs-common cifs-utils
sudo mkdir -p /nfs/jellyfin
sudo chown $USER:$USER /nfs/jellyfin
sudo chmod a+rwx /nfs/jellyfin

sudo sed -i 'SynologyDS716:/volume1/Jellyfin /nfs/jellyfin nfs defaults 0 0' /etc/fstab

sudo mount -a
