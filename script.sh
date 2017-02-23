# get infos
if [ -n "$1" ]; then
  project_dir=$1
  host=$3
  user=$4
  pass=$5
  db_name=$2
else
  read -p "PATH: " project_dir
  read -p "HOST NAME: " host
  read -p "USER NAME: " user
  printf "PASSWORD: "
  read -s pass
  read -p "\nDATABASE: " db_name
fi

# create new directory
backups="${HOME}/backups"
time_stamp=$(date +%Y-%m-%d-%T)
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
