#!/bin/bash
#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#
# DM default DB settings use database name 'dap' with user 'root'

DB="dap"
user="root"

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#

function backup {

	# decide for load or create

	read -n 1 -p "If you want to create a Dump press 'd' otherwise, if you want to load an existing Dump submit with enter, press 'x' to exit `echo $'\n> '`" -r dec
	
	case "$dec" in 
		'd') read -p "Please enter the Dumpname or absolute Path to create a Backup ('Name.sql'): `echo $'\n> '`" -r sql ; mysqldump -u $user $DB > $sql && echo "Successfully Created a Dump!" ;;
        'x') exit 1 ;;
		  *) read -p "Please enter the absolute Path of an existing Dump (/Users/path/to/file/*.sql) : `echo $'\n> '`" -r sql ; hadoop ;; 
	esac
}

function check {

	# Check if MySql is running

	test -n "$( pgrep mysql )" && echo "Mysql is Running!" || ( echo "Mysql was down, starting engine.." && mysql.server restart || echo "Your MySQL Engine is not running, please start it manually." && exit 1)

	# Check for the used Version and display databases, search for Database 'dap' and 

	echo "\n" && mysql --version && echo "\nDatabase for Datameer:" && mysql -u $user --execute="show databases; " | grep -q $DB && echo " '$DB' exists!\n" || echo " '$DB' does not exist!"
}

## Handle Parameters

function Decision {


case "$ced" in
	b|-b|backup) backup ; shift ;;
	c|-c|check) check ; shift ;;
	n|-n|new) new ; shift ;;
	-*) echo " $ced is not a valid Parameter! `echo $'\n> '` please use '-b' for Backup `echo $'\n> '` '-c' for Check `echo $'\n> '` '-n' if you want to delete your old and create a new Database " ; exit ;;
	 *) read -n 1 -p "Please Select a Valid Parameter: `echo $'\n> b - Backup'``echo $'\n> c - Check'` `echo $'\n> n - New'` `echo $'\n> '`" -r ced ; Decision $ced ;;
esac

}

function hadoop {

	if [ -z "$sql" ]; then

		echo "You did not enter a path!" && read -p "Please enter the absolute Path of an existing Dump (/Users/path/to/file/*.sql) : `echo $'\n> '`" -r sql

		if [ -z "$sql" ]; then
		
			echo "Empty Path, exiting" && exit
		
		fi
	fi
			
	mysql -u $user $DB < $sql
	mysql -u $user $DB -e "update dap_job_configuration set pull_type=0; update property set value="true" where name='authentication.internal'; update user set password='a4a88c0872bf652bb9ed803ece5fd6e82354838a9bf59ab4babb1dab322154e1' where name='admin'; update property set value='LOCAL' where name='hadoop.mode'; update property set value="false" where name='mail.enabled'; update property set value='' where name='hadoop.customPropertiesString'; update user set ext_authenticator_id='das.authenticator.extension' where name='admin';" && echo "Successfully executed Customer Dump Commands!"
	
	}

function new {

## Check if running and dap exists already 

		check && read -e -n 1 -p ">  You have an existing database $DB, submit with Enter to DELETE it! `echo $'\n> '` If you want to create a backup first submit with 'b / backup' otherwise your database will be deleted. `echo $'\n> '` (You can exit here if you submit with 'x') `echo $'\n '`" -r dec

		case "$dec" in
			'b'*) backup ;;
			 'x') exit 1 ;;
		       *) ;;
		esac

## Delete Database

		echo "\nDeleting the existing MySql Database\n3\n2\n1..\nLeft:" && mysql -u $user -e "drop database $DB ; show databases; " && echo "done" 

## Create new Database, like init-mysql

		mysql -u $user -e "CREATE DATABASE IF NOT EXISTS $DB DEFAULT CHARACTER SET utf8;" && mysql -u $user $DB -e "GRANT ALL PRIVILEGES ON $DB.* TO '$DB'@'localhost' IDENTIFIED BY '$DB' WITH GRANT OPTION;"

## Create Tables, external script
## Can be started from everywhere!

		path=$(pwd)
		read -p "Please select your desired Datameer Version (e.g 5.10): `echo $'\n> '`" -r V && export path=$path/MeinSQL/$V && mysql -u $user $DB < $path/create-tables.sql && echo "Successfully created Tables!" || echo "There was some Error when creating Tables!"
}



ced=$1
Decision ced
exit