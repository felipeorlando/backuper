# backuper
:open_file_folder: A shell script for backup projects and databases

### Requirements:
- Install zip: `sudo apt-get install zip`.
- The project directory must be on `/var/www/` directory.
- You must to create a `backups` directory on `$HOME`/`~/` directory.
- Change permission of script to excute. Ex: `chmod +x script.sh`.

### Usage:
You need to pass some parameters, in order:

1. Project file name
1. Database name
1. Database host name
1. Database user name
1. Database password

Ex: `/backuper/script.sh project project-db 127.0.0.1 root 123456`

based on [simple-database-backup](https://github.com/felipeorlando/simple-database-backup), by [Felipe Orlando](https://github.com/felipeorlando) :facepunch:
