#!/bin/bash

# Usage: script.sh [-r] [-c command] [-d directory]

while getopts "rc:d:" opt; do
  case $opt in
    r)
      recursive=true
      ;;
    c)
      command="$OPTARG"
      ;;
    d)
      directory="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -z $command ]]; then
  echo "Error: command must be specified with -c flag" >&2
  exit 1
fi

if [[ -z $directory ]]; then
  directory="./"
fi

if [[ -d $directory ]]; then
  if [[ $recursive ]]; then
    for file in $(find $directory -type f); do
      $command $file
    done
  else
    for file in $(ls $directory); do
      $command $directory/$file
    done
  fi
else
  echo "Error: $directory is not a valid directory" >&2
  exit 1
fi
