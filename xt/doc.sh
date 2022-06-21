#!/bin/bash
echo "

# Proch::N50

a small module to calculate N50 (total size, and total number of sequences) for a FASTA or FASTQ file. It's easy to install, with minimal dependencies.

 * [MetaCPAN](https://metacpan.org/pod/Proch::N50)

## Doc pages
" > README.md


dir="build-release"
out="docs"
mkdir -p "$out"
dzil build --in "$dir"
for i in "$dir"/bin/*; 
do
 b=$(basename $i .pl)
 pod2markdown < $i > "$out"/${b}.md
 echo " * [$b](docs/$b.md)" >> README.md
done

rm -rf "$dir"

echo "

# Citing

Telatin A, Fariselli P, Birolo G. 
**SeqFu: A Suite of Utilities for the Robust and Reproducible Manipulation of Sequence Files**.
Bioengineering 2021, 8, 59. [10.3390/bioengineering8050059](https://doi.org/10.3390/bioengineering8050059)" >> README.md
