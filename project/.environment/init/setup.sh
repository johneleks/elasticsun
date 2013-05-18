# This script performs one time setup actions, such as:
# - Setting necessary permissions for the user, so that it's not necessary to run certain 
#   commands, such as mount, using sudo
# - Installs necessary packages

# Set up permissions
sudo addgroup $USER fuse || fail "Failed to add user $USER to the fuse group"


echo "Setup completed successfully"
touch $setup_performed_file
