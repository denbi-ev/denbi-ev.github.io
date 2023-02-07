#!/bin/bash

# delete directory if it does already exist
if [ -d "denbiev.bioquant.uni-heidelberg.de" ]; then
    rm -r denbiev.bioquant.uni-heidelberg.de
fi

if [ -d "public" ]; then
    rm -r public
fi


# Download the de.NBI E.V. website
wget -r -np -k --no-check-certificate https://denbiev.bioquant.uni-heidelberg.de/

# array of files to be renamed
files=(about
       datenschutz
       impressum
       satzung
       )

# rename files without .html extension for selected files
for file in "${files[@]}"
do
    mv denbiev.bioquant.uni-heidelberg.de/$file denbiev.bioquant.uni-heidelberg.de/$file.html
done

# replace occurances of old url with new url
sed -i 's/href=\"about/href=\"about.html/g' denbiev.bioquant.uni-heidelberg.de/*.html
sed -i 's/href=\"datenschutz/href=\"datenschutz.html/g' denbiev.bioquant.uni-heidelberg.de/*.html
sed -i 's/href=\"impressum/href=\"impressum.html/g' denbiev.bioquant.uni-heidelberg.de/*.html
sed -i 's/href=\"satzung/href=\"satzung.html/g' denbiev.bioquant.uni-heidelberg.de/*.html

# copy files
cp static/* denbiev.bioquant.uni-heidelberg.de/
touch denbiev.bioquant.uni-heidelberg.de/.nojekyll

# rename directory
mv denbiev.bioquant.uni-heidelberg.de public