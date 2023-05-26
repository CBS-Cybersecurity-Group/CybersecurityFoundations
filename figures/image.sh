#!/bin/bash

# Hey hey hey!
# Convert those jpeg b*tches to png!
mogrify -format png *.jpg

# Walk through those pngs!
for f in *.png;
do
	echo "going for $f"
	#convert $f -matte-fill none -fuzz 1% -opaque white $f
	convert $f -fuzz 4.5% -transparent white $f

done
