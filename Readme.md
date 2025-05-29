ba76abf526b4c7ab22e8125cca69547f76559f703bd357c54bdf5d74be0bfd2b *xubuntu-24.04.2-desktop-amd64.iso
ed34b213296d5e02ceb4ec19cdc21ce5023b8f4d099aa18b876468c7cb1d41ba *xubuntu-24.04.2-minimal-amd64.iso
https://www.jimangel.io/posts/automate-ubuntu-22-04-lts-bare-metal/





URL=http://ftp.free.fr/mirrors/ftp.xubuntu.com/releases/24.04/release/xubuntu-24.04.2-minimal-amd64.iso
DEVICE=/dev/sda

DIR=/home/racine/Downloads
CIDATADIR=/tmp/cidata

ISO="${URL##*/}"
FILE=$DIR/xubuntu-24.04.2-minimal-amd64.iso

curl $URL | tee $FILE | sha256sum

# sha256sum $FILE

lsblk -p -n $DEVICE | awk '$6 =="part" && NF > 6 {print $NF}' | xargs -n1 -r -p sudo umount

sudo dd if=$FILE of=$DEVICE bs=1k conv=fdatasync status=progress

lsblk -p -n $DEVICE | awk '$6 =="part" && NF > 6 {print $NF}' | xargs -n1 -r -p sudo umount

# remove the USB

# Insert the samll one
sudo mkfs.vfat -I -F 32 -n 'CIDATA' $DEVICE

mkdir $CIDATADIR
sudo mount $DEVICE $CIDATADIR

touch $CIDATADIR/meta-data
