# Initialize project environment

export PROJECT_ROOT="$HOME/project"
export PROJECT_ENVIRONMENT_ROOT=$PROJECT_ROOT/.environment
export PROJECT_ENVIRONMENT_INIT_ROOT=$PROJECT_ENVIRONMENT_ROOT/init

export PROJECT_ENVIRONMENT_SETUP_SCRIPT=$PROJECT_ENVIRONMENT_INIT_ROOT/setup.sh
export PROJECT_ENVIRONMENT_INIT_SCRIPT=$PROJECT_ENVIRONMENT_INIT_ROOT/init.sh
export PROJECT_ENVIRONMENT_INIT_SCRIPT_DEBUG_LOG=0

# Import common helper functions
if [ -f $PROJECT_ENVIRONMENT_INIT_ROOT/functions.sh ]; then
    . $PROJECT_ENVIRONMENT_INIT_ROOT/functions.sh
fi

# Run one time set up script
setup_performed_file=$PROJECT_ENVIRONMENT_INIT_ROOT/setup_performed
if [ ! -f $setup_performed_file ]; then
    if [ -x "$PROJECT_ENVIRONMENT_SETUP_SCRIPT" ]; then
        
        echo "Running one time project environment setup script"
        . $PROJECT_ENVIRONMENT_SETUP_SCRIPT
    fi
fi

init_scripts_root=$PROJECT_ENVIRONMENT_INIT_ROOT/scripts
if [ -d $init_scripts_root ]; then

    for script in $(ls $init_scripts_root); do
        script=$init_scripts_root/$script

        echo "Running project init script: $script"
        . $script
    done
fi
