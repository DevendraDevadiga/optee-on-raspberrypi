# Creating images etc, could wipe out a drive on the system, therefore we don't
# want to automate that in script or make target. Instead we just simply provide
# the steps here.
.PHONY: img-help
img-help:
	@echo "$$ fdisk /dev/sdx   # where sdx is the name of your sd-card"
	@echo "   > p             # prints partition table"
	@echo "   > d             # repeat until all partitions are deleted"
	@echo "   > n             # create a new partition"
	@echo "   > p             # create primary"
	@echo "   > 1             # make it the first partition"
	@echo "   > <enter>       # use the default sector"
	@echo "   > +64M          # create a boot partition with 64MB of space"
	@echo "   > n             # create rootfs partition"
	@echo "   > p"
	@echo "   > 2"
	@echo "   > <enter>"
	@echo "   > <enter>       # fill the remaining disk, adjust size to fit your needs"
	@echo "   > t             # change partition type"
	@echo "   > 1             # select first partition"
	@echo "   > e             # use type 'e' (FAT16)"
	@echo "   > a             # make partition bootable"
	@echo "   > 1             # select first partition"
	@echo "   > p             # double check everything looks right"
	@echo "   > w             # write partition table to disk."
	@echo ""
	@echo "run the following as root"
	@echo "   $$ mkfs.vfat -F16 -n BOOT /dev/sdx1"
	@echo "   $$ mkdir -p /media/boot"
	@echo "   $$ mount /dev/sdx1 /media/boot"
	@echo "   $$ cd /media"
	@echo "   $$ gunzip -cd $(ROOT)/out-br/images/rootfs.cpio.gz | sudo cpio -idmv \"boot/*\""
	@echo "   $$ umount boot"
	@echo ""
	@echo "run the following as root"
	@echo "   $$ mkfs.ext4 -L rootfs /dev/sdx2"
	@echo "   $$ mkdir -p /media/rootfs"
	@echo "   $$ mount /dev/sdx2 /media/rootfs"
	@echo "   $$ cd rootfs"
	@echo "   $$ gunzip -cd $(ROOT)/out-br/images/rootfs.cpio.gz | sudo cpio -idmv"
	@echo "   $$ rm -rf /media/rootfs/boot/*"
	@echo "   $$ cd .. && umount rootfs"
