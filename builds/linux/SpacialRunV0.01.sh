#!/bin/sh
echo -ne '\033c\033]0;Spacial Run\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/SpacialRunV0.01.x86_64" "$@"
