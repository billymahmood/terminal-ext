function b_run() {
    if [ -z "$1" ];
        then
            PLATFORM="android"
        else
            PLATFORM=$1
    fi
    cordova run $PLATFORM
}

function b_build() {
    if [ -z "$1" ];
        then
            PLATFORM="android"
        else
            PLATFORM=$1
    fi
    cordova build $PLATFORM
}