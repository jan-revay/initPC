#!/bin/bash
set -euo pipefail

# Find all .sh files and process each one
find . -type f -name "*.sh" -print0 | while IFS= read -r -d '' file; do
    # Check if file contains "prelude.sh"
    if grep -qE "^\.[[:space:]]+(\.\./)*prelude\.sh$" "$file"; then
        echo "Processing: $file"

        # Extract the prelude line (first occurrence only)
        prelude=$(grep -E -m1 "^\.[[:space:]]+(\.\./)*prelude\.sh$" "$file")

        # Remove all lines containing "prelude.sh"
        grep -vE "^\.[[:space:]]+(\.\./)*prelude\.sh$" "$file" > "$file.tmp"

        # Copy permissions from original file to temp file
        chmod --reference="$file" "$file.tmp"

        # Insert prelude line after line 1 (making it line 2)
        sed -i "1a\\
$prelude" "$file.tmp"

        # Replace original file
        mv "$file.tmp" "$file"
    fi
done

echo "Done!"
