function gruntRun() {
    if [ -f "$(PWD)/gruntfile.js" ]; then
        sleep 1
        echo "Running Grunt"
        grunt
        
    fi

    if [ ! -f "$(PWD)/gruntfile.js" ]; then
        echo "No grunt file to run."
    fi
}