#!/bin/bash
ten_days_ago=$(date --date="3 days ago" +"%Y-%m-%d")
date_now=$(date '+%Y-%m-%d')


main_folder="project-app"
folder_backup="${main_folder}_${date_now}"
folder_backup_old="${main_folder}_${ten_days_ago}"

db_user="db_user"
db_password="db_password"
db_name="database_db"
db_backup="${db_name}_${date_now}"
db_backup_old="${db_name}_${ten_days_ago}"


zip -r $folder_backup.zip $main_folder
mysqldump -u $db_user -p$db_password $db_name > $PWD/$db_backup.sql


[ -e $folder_backup_old.zip ] && rm $folder_backup_old.zip
[ -e $db_backup_old.zip ] && rm $db_backup_old.zip


echo new backup $folder_backup.zip
echo delete backup $folder_backup_old.zip
echo new SQL backup $db_backup.sql
echo delete SQL backup $db_backup_old.sql

#just setup in crobtab backup every 3 days, so went zip run on 9 jan, first backup on 1 jan will remove. so you have backup on 3, 6, and 9 jan
#
#how to setup on cron tab like below:
#
#crontab -e
#0 1 */3 * * /path/to/program.sh
#
#explanation
#0 1: execute on minute 0, hour 1 am
#*/3: every 3 days
#* *: run all month
#
#how to restore mysql & unzip zip
#create database first if you want
#mysql -u $db_user -p -e "CREATE DATABASE $db_name;"
#restore db with command
#mysql -u $db_user -p$db_password $db_name < $PWD/$db_backup.sql
#
#to unzip just:
#unzip filename.zip
