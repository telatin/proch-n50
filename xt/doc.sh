#!/bin/bash

dir="build-release"
out="docs"
mkdir -p "$out"
dzil build --in "$dir"
for i in "$dir"/bin/*; 
do
 pod2markdown < $i > "$out"/$(basename $i).md
done

rm -rf "$dir"