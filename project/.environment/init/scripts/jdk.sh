# JDK
archive=$(share_root)/jdk-7u21-linux-x64.tar.gz
#mountpoint=$(tool_root)/jdk
mountpoint=$HOME/bin/jdk
binpath=$mountpoint/jdk1.7.0_21/bin

unpack $archive $mountpoint unpack_targz $binpath
## mount_archive $archive $mountpoint
append_path $binpath
