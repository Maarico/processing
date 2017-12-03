
for file in ./*/*.pgm ; do 
	echo "Diese Datei: $file wurde convertiert"
	fname=$(basename "$file")
	fdir=$(dirname "$file")
	convert "$fdir/$fname" "$fdir/$fname.png"
	rm "$fdir/$fname"
done