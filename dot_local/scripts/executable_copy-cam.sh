#!/bin/bash

# --- 1. Configuration ---
CAM_MOUNT="$HOME/cam"
CAM_DEVICE="/dev/sdb1"
NAS_ROOT="$HOME/Downloads/family/Sony A6400"
NAS_PATH="//192.168.0.182/family"

# --- 2. Mount Checks ---
if ! mountpoint -q "$CAM_MOUNT"; then
    echo "Mounting Camera SD..."
    sudo mount /dev/sdb1 "$CAM_MOUNT" -o uid=$(id -u),gid=$(id -g) || exit 1
fi

if ! mountpoint -q "$HOME/Downloads/family"; then
    echo "Mounting NAS..."
    sudo mount -t cifs "$NAS_PATH" "$HOME/Downloads/family" \
        -o username=user,uid=$(id -u),gid=$(id -g),file_mode=0664,dir_mode=0775 || exit 1
fi

# --- 3. Processing Function ---
process_files() {
    local ext=$1
    local type_folder=$2
    
    echo "Processing $type_folder (*.$ext)..."

    find "$CAM_MOUNT" -type f -iname "*.$ext" | while read -r src_file; do
        
        # Extract Date (using exiftool for JPG/ARW, ffprobe for MP4)
        if [[ "$ext" == "ARW" || "$ext" == "JPG" ]]; then
            creation_date=$(exiftool -d "%Y%m%d" -DateTimeOriginal -S -s "$src_file")
        else
            creation_date=$(ffprobe -v quiet -select_streams v:0 -show_entries stream_tags=creation_time -of default=noprint_wrappers=1:nokey=1 "$src_file" | cut -d'T' -f1 | sed 's/-//g')
        fi

        [ -z "$creation_date" ] && creation_date=$(date -r "$src_file" +%Y%m%d)

        year_folder="${creation_date:0:4}"
        target_dir="${NAS_ROOT}/${type_folder}/${year_folder}"
        mkdir -p "$target_dir"

        dest_name="${target_dir}/${creation_date}.${ext}"
        counter=1
        while [ -e "$dest_name" ]; do
            dest_name="${target_dir}/${creation_date}_${counter}.${ext}"
            ((counter++))
        done

        # Copy instead of Move to avoid the 'Permission Denied' issue on SD
        echo "Copying: $(basename "$src_file") -> ${type_folder}/${year_folder}/$(basename "$dest_name")"
        cp "$src_file" "$dest_name"
    done
}

# --- 4. Run Import to NAS ---
process_files "MP4" "videos"
process_files "ARW" "pictures"
#process_files "JPG" "pictures" # JPGs also go to pictures/year

# --- 5. Upload JPGs to Immich ---
echo "Uploading JPGs to Immich..."
NODE_TLS_REJECT_UNAUTHORIZED=0 immich upload \
  --recursive \
  "$CAM_MOUNT/DCIM/" # This will upload all JPGs found in the NAS picture folder

echo "Success! NAS updated and Immich sync started."
