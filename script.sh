# $1 = project_dir, $2 = database_name, $3 = host, $4 = user, $5 = password

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
time_stamp=$(date +%Y-%m-%d-%T)
backups="${HOME}/backups"
backup_directory="${backups}/${time_stamp}"
mkdir "${backup_directory}"

# create database backup
db_file="${backup_directory}/database.sql"
mysqldump -h $host -u $user --password=$pass $db_name > $db_file

# create project backup
project="/var/www/${project_dir}"
cp -r $project "${backup_directory}/"

# compacting the backup directory
new_tar="${backup_directory}.tar.gz"
tar -zcvf $new_tar $backup_directory

# removing dir
rm -rf $backup_directory
