## Get the platform name
## this function cannot be invoked by b
function getPlatform() {
    COMMAND="cordova"

    if [ -f $(PWD)/ionic.project ]; 
        then
            COMMAND="ionic"
    fi
    
    echo $COMMAND
}

function b_run() {
    PLATFORM="android"

    if [ ! -z "$1" ];
        then
            PLATFORM=$1
    fi

    $(getPlatform) run $PLATFORM
    echo "command executed - $(getPlatform) run $PLATFORM"   
}

function b_build() {
    if [ -z "$1" ];
        then
            PLATFORM="android"
        else
            PLATFORM=$1
    fi

    $(getPlatform) build $PLATFORM
    echo "command executed - $(getPlatform) build $PLATFORM"    
}