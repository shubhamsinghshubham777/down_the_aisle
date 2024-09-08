#!/bin/bash

# Check if a version number was provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide a Flutter version number."
    echo "Usage: $0 <version_number>"
    exit 1
fi

# Store the version number
VERSION=$1

# Function to change directory and use fvm
change_dir_and_use_fvm() {
    local dir=$1
    echo "Switching Flutter version in $dir directory..."
    cd "$dir" || { echo "Error: Unable to change to the $dir directory."; exit 1; }
    fvm use "$VERSION" || { echo "Error: fvm command failed in $dir. Make sure fvm is installed and the version is available."; exit 1; }
    cd ..
}

# Function to update flutter-version in README.md
update_readme() {
    echo "Updating flutter-version in README.md..."
    sed -i '' "s|chmod +x scripts/change_flutter_version.sh; ./scripts/change_flutter_version.sh 3.*|chmod +x scripts/change_flutter_version.sh; ./scripts/change_flutter_version.sh $VERSION|" README.md
}

# Execute for frontend
change_dir_and_use_fvm "frontend"

# Execute for backend
change_dir_and_use_fvm "backend"

# Update README.md
update_readme

echo -e "\033[32m✓\033[0m Successfully switched to \033[36mFlutter Version $VERSION\033[0m in both frontend and backend directories and updated the GitHub workflow."
