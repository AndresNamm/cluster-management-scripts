#!/bin/sh
for zip in *.rar
do
  dirname=`echo $zip | sed 's/\.rar$//'`
  if mkdir "$dirname"
  then
    if cd "$dirname"
    then
      unrar x -r ../"$zip"
      cd ..
      rm -f $zip # Uncomment to delete the original zip file
    else
      echo "Could not unpack $zip - cd failed"
    fi
  else
    echo "Could not unpack $zip - mkdir failed"
  fi
done




