[[ $( sudo pvdisplay | egrep "nvme1n1|nvme2n1" > /dev/null 2>&1 ) ]] || sudo pvcreate /dev/nvme1n1 /dev/nvme2n1 > /dev/null 2>&1
[[ $( sudo vgdisplay | grep vdoDev > /dev/null 2>&1 ) ]] || sudo vgcreate vdoDev /dev/nvme1n1 /dev/nvme2n1 > /dev/null 2>&1
[[ $( sudo lvdisplay | grep vdoLV > /dev/null 2>&1 ) ]] || sudo lvcreate -n vdoLV -l 100%FREE vdoDev > /dev/null 2>&1
[[ $( sudo vdo list | grep LA > /dev/null 2>&1 ) ]] || sudo vdo create --name=LA --device=/dev/vdoDev/vdoLV --vdoLogicalSize=150G --sparseIndex=enabled > /dev/null 2>&1
sudo blkid | grep LA | grep xfs > /dev/null 2>&1 || echo -e "\nPlease wait for your lab environment to be fully provisioned, it may take up to 5 minutes...\n"
[[ $( sudo blkid | grep LA | grep xfs > /dev/null 2>&1 ) ]] || sudo mkfs.xfs /dev/mapper/LA > /dev/null 2>&1
[[ $( ls -d /mnt/vdo  > /dev/null 2>&1 ) ]] || sudo mkdir /mnt/vdo > /dev/null 2>&1
[[ $( sudo mount | grep LA > /dev/null 2>&1 ) ]] || sudo mount /dev/mapper/LA /mnt/vdo > /dev/null 2>&1
