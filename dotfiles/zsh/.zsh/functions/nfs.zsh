mount_nfs () {
  directory_name = $1

  sudo mkdir -p /nfs/$directory_name
  sudo chown $USER:$USER /nfs/$directory_name
  sudo chmod a+rwx /nfs/$directory_name

  echo "SynologyDS716:/volume1/$directory_name /nfs/$directory_name nfs defaults 0 0" | sudo tee -a /etc/fstab
  sudo mount -a
}
