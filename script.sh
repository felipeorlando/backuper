#!/bin/bash

# get infos
if [ -n "$1" ]; then
  project_dir=$1
  db_name=$2
  host=$3
  user=$4
  pass=$5
  inner_dir=$6
else
  read -p     'PATH: ' project_dir
  read -p     'HOST NAME: ' host
  read -p     'USER NAME: '
  read -s -p  'PASSWORD: ' pass
  read -p     $'\nDATABASE: ' db_name
  read -p     'PROJECT DIRECTORY: ' inner_dir
fi


# create new directory
backups="${HOME}/backups"
time_stamp=$(date +%Y-%m-%d-%T)

if [ -n "$inner_dir" ]; then
  new_directory="${backups}/${inner_dir}"
  if [ ! -d "$new_directory" ]; then
    mkdir "${backups}/${inner_dir}"
  fi
  backups="$new_directory"
fi

backup_directory="${backups}/${time_stamp}"
mkdir "${backup_directory}"


# create database backup
db_file="${backup_directory}/database.sql"
mysqldump --host=$host --user=$user --password=$pass $db_name > $db_file


# create project backup
project="/var/www/${project_dir}"
cp -r $project "${backup_directory}/"


# compacting the backup directory
directory_zip="${backup_directory}.zip"
cd $backups && zip -r $directory_zip $time_stamp


# removing dir
rm -rf $backup_directory
