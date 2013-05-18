# Error reporting functions

function fail() {
    local msg=$1

    echo "FAILURE: $0: " $msg >&2

    exit 1
}

# Loggng functions

function log() {
    local msg=$1
    echo $msg
}

function log_debug() {
    if [ "$PROJECT_ENVIRONMENT_INIT_SCRIPT_DEBUG_LOG" == "1" ]; then
        local msg=$1
        log "DEBUG: $msg"
    fi
}

# PATH manipulation functions

function project_root {
    echo $PROJECT_ROOT
}

function tool_root {
    echo $(project_root)/tool
}

function share_root {
    echo $(project_root)/share
}

function append_path() {
    local path=$1

    if ! [[ ":$PATH:" == *":$path:"* ]]; then
        PATH=$PATH:$path
        export PATH
    fi
}

# Archivemount

function mount_archive() {
    local archive=$1
    local mountpoint=$2

    if ! [ -f $jrearchive ]; then 

        fail "Archive does not exist: $archive"
    fi

    if ! [ -d $mountpoint ]; then
        mkdir -p $mountpoint || fail "Failed to create directory $mountpoint"
    fi

    if [ ! $(which archivemount) ]; then
        fail "'archivemount' package must be installed on the system"
    else
        # If the mountpoint is non-empty, unmount first
        if [ "$(ls -A $mountpoint)" ]; then
            fusermount -u $mountpoint || fail "Failed to unmount non-empty mountpoint $mountpoint"
        fi            

        archivemount $archive $mountpoint || fail "Failed to mount archive $archive on $mountpoint"
    fi

}

# Package unpacking

function unpack {
    local archive=$1
    local targetdir=$2
    local unpackfunc=$3
    local filetoexist=$4

    if [ ! -f $filetoexist ]; then
        mkdir -p $targetdir || fail "Failed to create directory $targetdir"
        $unpackfunc $archive $targetdir
    fi
}

function unpack_zip {
    local archive=$1
    local targetdir=$2

    unzip $archive -d $targetdir || fail "Failed to unpack ZIP $archive to $targetdir"
}

function unpack_targz {
    local archive=$1
    local targetdir=$2

    echo "RUNNING: tar -xvfz $archive --directory=$targetdir"
    tar xvfz $archive --directory=$targetdir || "Failed to unpack TARGZ archive $archive to $targetdir"
}
