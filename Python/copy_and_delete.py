import os
import shutil
import filecmp

def copy_and_delete(source_dir, target_dir):
    # Ensure target directory exists
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    # Copy files from source to target directory
    for root, dirs, files in os.walk(source_dir):
        # Create corresponding directories in the target
        for dir_name in dirs:
            source_subdir = os.path.join(root, dir_name)
            target_subdir = os.path.join(target_dir, os.path.relpath(source_subdir, source_dir))
            if not os.path.exists(target_subdir):
                os.makedirs(target_subdir)

        # Copy files to target directory if they don't exist or have different contents
        for file in files:
            source_path = os.path.join(root, file)
            target_path = os.path.join(target_dir, os.path.relpath(source_path, source_dir))

            if not os.path.exists(target_path) or not filecmp.cmp(source_path, target_path):
                shutil.copy2(source_path, target_path)
                print(f"Copied: {source_path} -> {target_path}")

    # Delete extra files in the target directory
    for root, dirs, files in os.walk(target_dir):
        for file in files:
            source_path = os.path.join(source_dir, os.path.relpath(os.path.join(root, file), target_dir))
            target_path = os.path.join(root, file)

            # Delete extra file in target directory
            if not os.path.exists(source_path):
                os.remove(target_path)
                print(f"Deleted: {target_path}")

# Example usage:
source_directory = "/path/to/source"
target_directory = "/path/to/target"

copy_and_delete(source_directory, target_directory)
