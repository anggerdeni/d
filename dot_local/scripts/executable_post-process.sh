#!/bin/bash
process_files() {
    local ext=$2
    
    echo "Processing (*.$ext)..."

    find $1 -type f -iname "*.$ext" | while read -r src_file; do
        
        # Extract Date (using exiftool for JPG/ARW, ffprobe for MP4)
        if [[ "$ext" == "ARW" || "$ext" == "JPG" ]]; then
            creation_date=$(exiftool -d "%Y%m%d%H%M%S" -DateTimeOriginal -S -s "$src_file")
        else
            creation_date=$(ffprobe -v quiet -select_streams v:0 -show_entries stream_tags=creation_time -of default=noprint_wrappers=1:nokey=1 "$src_file" | sed 's/T/-/g' | sed 's/:/-/g' | cut -d'.' -f1 | sed 's/-//g')
        fi

        [ -z "$creation_date" ] && creation_date=$(date -r "$src_file" +%Y%m%d%H%M%S)

        fpath=$(realpath $src_file)
        target_dir=$(dirname "$fpath")

        dest_name="${target_dir}/${creation_date}.${ext}"
        counter=1
        while [ -e "$dest_name" ]; do
            dest_name="${target_dir}/${creation_date}_${counter}.${ext}"
            ((counter++))
        done

        # Copy instead of Move to avoid the 'Permission Denied' issue on SD
        echo "renaming: $(basename "$src_file") -> $dest_name"
        mv "$src_file" "$dest_name"
    done
}

# --- 4. Run Import to NAS ---
process_files $1 $2

echo "Success!"
