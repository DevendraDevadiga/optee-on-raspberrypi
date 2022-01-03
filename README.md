# OP-TEE 3.15 on Raspberry Pi 3B
OP-TEE 3.15 is tested on Raspberry PI 3B. The tested binaries are provideed.

Download the binaries from git
```ruby 
$ git clone https://github.com/DevendraDevadiga/optee-on-raspberrypi.git
$ cd optee-on-raspberrypi
$ ls 
LICENSE  Makefile  optee-on-raspberry-pi-3b-log.txt  README.md  rootfs.cpio.gz
```

Prepare the SD card to copy/flash the images:

```ruby
$ make
$ fdisk /dev/sdx   # where sdx is the name of your sd-card
   > p             # prints partition table
   > d             # repeat until all partitions are deleted
   > n             # create a new partition
   > p             # create primary
   > 1             # make it the first partition
   > <enter>       # use the default sector
   > +64M          # create a boot partition with 64MB of space
   > n             # create rootfs partition
   > p
   > 2
   > <enter>
   > <enter>       # fill the remaining disk, adjust size to fit your needs
   > t             # change partition type
   > 1             # select first partition
   > e             # use type 'e' (FAT16)
   > a             # make partition bootable
   > 1             # select first partition
   > p             # double check everything looks right
   > w             # write partition table to disk.

run the following as root
   $ mkfs.vfat -F16 -n BOOT /dev/sdx1
   $ mkdir -p /media/boot
   $ mount /dev/sdx1 /media/boot
   $ cd /media
   $ gunzip -cd /out-br/images/rootfs.cpio.gz | sudo cpio -idmv "boot/*"
   $ umount boot

run the following as root
   $ mkfs.ext4 -L rootfs /dev/sdx2
   $ mkdir -p /media/rootfs
   $ mount /dev/sdx2 /media/rootfs
   $ cd rootfs
   $ gunzip -cd /out-br/images/rootfs.cpio.gz | sudo cpio -idmv
   $ rm -rf /media/rootfs/boot/*
   $ cd .. && umount rootfs
```
Insert the board and boot.
Login as "root".

```ruby 
Welcome to Buildroot, type root or test to login
buildroot login: root
#
# ls /lib/optee_armtz/
12345678-5b69-11e4-9dbb-101f74f00099.ta
25497083-a58a-4fc5-8a72-1ad7b69b8562.ta
2a287631-de1b-4fdd-a55c-b9312e40769a.ta
380231ac-fb99-47ad-a689-9e017eb6e78a.ta
484d4143-2d53-4841-3120-4a6f636b6542.ta
528938ce-fc59-11e8-8eb2-f2801f1b9fd1.ta
5b9e0e40-2636-11e1-ad9e-0002a5d5c51b.ta
5ce0c432-0ab0-40e5-a056-782ca0e6aba2.ta
5dbac793-f574-4871-8ad3-04331ec17f24.ta
614789f2-39c0-4ebf-b235-92b32ac107ed.ta
731e279e-aafb-4575-a771-38caa6f0cca6.ta
873bcd08-c2c3-11e6-a937-d0bf9c45c61c.ta
8aaaf200-2450-11e4-abe2-0002a5d5c51b.ta
a4c04d50-f180-11e8-8eb2-f2801f1b9fd1.ta
a734eed9-d6a1-4244-aa50-7c99719e7b7b.ta
b3091a65-9751-4784-abf7-0298a7cc35ba.ta
b689f2a7-8adf-477a-9f99-32e90c0ad0a2.ta
b6c53aba-9669-4668-a7f2-205629d00f86.ta
c3f6e2c0-3548-11e1-b86c-0800200c9a66.ta
cb3e5ba0-adf1-11e0-998b-0002a5d5c51b.ta
d17f73a0-36ef-11e1-984a-0002a5d5c51b.ta
e13010e0-2ae1-11e5-896a-0002a5d5c51b.ta
e626662e-c0e2-485c-b8c8-09fbce6edf3d.ta
e6a33ed4-562b-463a-bb7e-ff5e15a493c8.ta
ee90d523-90ad-46a0-859d-8eea0b150086.ta
f157cda0-550c-11e5-a6fa-0002a5d5c51b.ta
f4e750bb-1437-4fbf-8785-8d3580c34994.ta
ffd2bded-ab7d-4988-95ee-e4962fff7154.ta
#
# ls /usr/bin/optee_*
/usr/bin/optee_example_acipher         /usr/bin/optee_example_plugins
/usr/bin/optee_example_aes             /usr/bin/optee_example_random
/usr/bin/optee_example_hello_world     /usr/bin/optee_example_secure_storage
/usr/bin/optee_example_hotp
#

# optee_example_hello_world
D/TC:? 0 tee_ta_init_pseudo_ta_session:299 Lookup pseudo TA 8aaaf200-2450-11e4-abe2-0002a5d5c51b
D/TC:? 0 ldelf_load_ldelf:91 ldelf load address 0x40006000
D/LD:  ldelf:134 Loading TS 8aaaf200-2450-11e4-abe2-0002a5d5c51b
D/TC:? 0 ldelf_syscall_open_bin:142 Lookup user TA ELF 8aaaf200-2450-11e4-abe2-0002a5d5c51b (Secure Storage TA)
D/TC:? 0 ldelf_syscall_open_bin:146 res=0xffff0008
D/TC:? 0 ldelf_syscall_open_bin:142 Lookup user TA ELF 8aaaf200-2450-11e4-abe2-0002a5d5c51b (REE)
D/TC:? 0 ldelf_syscall_open_bin:146 res=0
D/LD:  ldelf:168 ELF (8aaaf200-2450-11e4-abe2-0002a5d5c51b) at 0x40077000
D/TA:  TA_CreateEntryPoint:39 has been called
D/TA:  TA_OpenSessionEntryPoint:68 has been called
I/TA: Hello World!
InvokingD/TA:  inc_value:105 has been called
 TA to incrementI/TA: Got value: 42 from NW
 42
I/TA: Increase value to: 43
TA increD/TC:? 0 tee_ta_close_session:512 csess 0x1017a980 id 1
mented vD/TC:? 0 tee_ta_close_session:531 Destroy session
alue to I/TA: Goodbye!
43
D/TA:  TA_DestroyEntryPoint:50 has been called
D/TC:? 0 destroy_context:308 Destroy TA ctx (0x1017a920)
#
# xtest
Run testD/TC:? 0 tee_ta_init_pseudo_ta_session:299 Lookup pseudo TA d96a5b40-c3e5-21e3-8794-1002a5d5c61b
 suite wD/TC:? 0 tee_ta_init_pseudo_ta_session:312 Open invoke_tests.pta
ith leveD/TC:? 0 tee_ta_init_pseudo_ta_session:329 invoke_tests.pta : d96a5b40-c3e5-21e3-8794-1002a5d5c61b
l=0
................
................
................
+-----------------------------------------------------
Result of testsuite regression:
regression_1001 OK
regression_1002 OK
regression_1003 OK
regression_1004 OK
regression_1005 OK
regression_1006 OK
regression_1007 OK
regression_1008 OK
regression_1009 OK
regression_1010 OK
regression_1011 OK
regression_1012 OK
regression_1013 OK
regression_1015 OK
regression_1016 OK
regression_1017 OK
regression_1018 OK
regression_1019 OK
regression_1020 OK
regression_1021 OK
regression_1022 OK
regression_1023 OK
regression_1025 OK
regression_1026 OK
regression_1027 OK
regression_1028 OK
regression_1029 OK
regression_1030 OK
regression_1031 OK
regression_1032 OK
regression_1033 OK
regression_1034 OK
regression_2001 OK
regression_2002 OK
regression_2003 OK
regression_2004 OK
regression_4001 OK
regression_4002 OK
regression_4003 OK
regression_4004 OK
regression_4005 OK
regression_4006 OK
regression_4007_dh OK
regression_4007_dsa OK
regression_4007_ecc OK
regression_4007_rsa OK
regression_4007_symmetric OK
regression_4008 OK
regression_4009 OK
regression_4010 OK
regression_4011 OK
regression_4012 OK
regression_4013 OK
regression_4014 OK
regression_4101 OK
regression_4102 OK
regression_4103 OK
regression_4104 OK
regression_4105 OK
regression_4106 OK
regression_4107 OK
regression_4108 OK
regression_4109 OK
regression_4110 OK
regression_4111 OK
regression_4012 OK
regression_4013 OK
regression_4014 OK
regression_4101 OK
regression_4102 OK
regression_4103 OK
regression_4104 OK
regression_4105 OK
regression_4106 OK
regression_4107 OK
regression_4108 OK
regression_4109 OK
regression_4110 OK
regression_4111 OK
regression_4112 OK
regression_4113 OK
regression_4114 OK
regression_5006 OK
regression_6001 OK
regression_6002 OK
regression_6003 OK
regression_6004 OK
regression_6005 OK
regression_6006 OK
regression_6007 OK
regression_6008 OK
regression_6009 OK
regression_6010 OK
regression_6012 OK
regression_6013 OK
regression_6014 OK
regression_6015 OK
regression_6016 OK
regression_6017 OK
regression_6018 OK
regression_6019 OK
regression_6020 OK
regression_8001 OK
regression_8002 OK
regression_8101 OK
regression_8102 OK
regression_8103 OK
+-----------------------------------------------------
26182 subtests of which 0 failed
93 test cases of which 0 failed
0 test cases were skipped
TEE test application done!
#
````
