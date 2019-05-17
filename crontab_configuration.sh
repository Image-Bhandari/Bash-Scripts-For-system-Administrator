# PROGRAM BY : IMAGE BHANDARI
# ASSIGNMENT 2 
# OPERATING SYSTEM MODULE
choose_one(){ #function for let user choose the options
	echo "Choose One from the below option"
	echo "Press 1 for archiving files 7 days ago"
	echo "Press 2 to customize yourself"
	read value #reading the user vlaue
	if [[ $value =~ 1 ]] #checking values
	then
		sevendaysago #calling a funciton for taking backup for 7 days passed files
	elif [[ $value =~ 2 ]]; then #checking values
		read_minute #callig a function for taking minute input 
		else
			echo "Invalid number please retry"
			choose_one #redirecting to the same function if value is incorrect
			echo ""
	fi		
}
sevendaysago(){ #funciton for archiving files 7 days agho
	find ~/Desktop/Operating\ Systems/Topic\ 18/ -atime -7 | xargs tar cvf `date -d "7 days ago" +%Y-%m-%d-archive.tar`
	#finds the files form the given path and archives 7 days ago files and names it accordingly to the date.
}
read_minute(){ # function for reading time in minutes
echo -e "$yellow Input time in minute (0-59) $green " #instruction
read minute # reading minute for periodic update
if [[ $minute =~ ^[0-5]?[0-9]$|^$ ]] # checking the condition if the time is between 0-59 minutes
	then
		if [[ $minute =~ ^$ ]] # checking for null value
		then
			minute='*' # default value is * if no value is entered
		fi
		read_hour #calling a function which takes hour input
	else
		echo -e " $red Invalid Input" #invalid waring if the value is wrong
		echo "Please try again" #invalid waring if the value is wrong
		read_minute # redirecting to the same function to take the same input which was entered wrong
fi
}
read_hour(){ # function for reading time in hour
echo -e "$yellow Input time in hour(0-23) $green" #instruction
read hour # reading hour for periodic update
if [[ $hour =~ ^[0-2]?[0-9]$|^$ ]] && [[ $hour -lt 24 ]] #checking condition if the hour lies between 0-23 and less than 24
	then
		if [[ $hour =~ ^$ ]] #checking if null value is entered
		then
			hour='*' # incase of null value default will be * which means all the time, in this case hourly
		fi
		read_day #calling a function which takes day input
		else
		echo -e "$red Invalid Input" #invalid waring if the value is wrong
		echo "Please try again" #invalid waring if the value is wrong
		read_hour # redirecting to the same function to take the same input which was entered wrong
fi

}

read_day(){ # function for reading time in hour
echo -e "$yellow Input date day(1-31) $green" #instruction
read day # reading date for periodic update
if [[ $day =~ ^[0-3]?[0-9]$|^$ ]] && [[ $day -lt 32 ]] # checking if the date input is less than 32 and is a valid input
	then
		if [[ $day =~ ^$ ]] #checking if null value is entered
		then
			day='*' # incase of null value default will be * which means all the time, in this case daily
		fi
		read_month #calling a function which takes month input
		else
		echo -e "$red Invalid Input" #invalid waring if the value is wrong
		echo "Please try again" #invalid waring if the value is wrong
		read_day # redirecting to the same function to take the same input which was entered wrong
	fi
}

read_month(){ # function for reading time in month
echo -e "$yellow Input month nummber(1-12) $green" #instruction
read month # reading month for periodic update
if [[ $month =~ ^[0-1]?[0-9]$|^$ ]] && [[ $month -lt 13 ]] # checking if the month input is less than 13 and is a valid input
	then
		if [[ $month =~ ^$ ]] #checking if null value is entered
		then
			month='*' # incase of null value default will be * which means all the time, in this case monthly
		fi
		read_week #calling a function which takes week input
		else
		echo -e "$red Invalid Input" #invalid waring if the value is wrong
		echo "Please try again" #invalid waring if the value is wrong
		read_month # redirecting to the same function to take the same input which was entered wrong
	fi
}

read_week(){
echo -e "$yellow Input day of week (0-6) $green" #instruction
echo -e "SUNDAY IS MARKED AS 0" #instruction
echo -e "MONDAY IS MARKED AS 1 and so on .. " #instruction
read week # reading week for periodic update
if [[ $week =~ ^[0-6]$|^$ ]]
	then
		if [[ $week =~ ^$ ]] #checking if null value is entered
		then
			week='*' # incase of null value default will be * which means all the time, in this case weekly
		fi

		else
		echo -e "$red Invalid Input" #invalid waring if the value is wrong
		echo "Please try again" #invalid waring if the value is wrong
		read_week # redirecting to the same function to take the same input which was entered wrong
	fi
}

#
#
# PROGRAM STARTS FROM THIS SECTION !!
#
#


#Initialization of required color 
red='\033[1;31m' #red font color
green='\033[1;32m' #green font color
yellow='\033[1;33m' #yellow font color
purple='\033[1;35;52m' #purple font color
clear #program begains from this point..

echo -e "$purple WELCOME IN ARCIHIVING PROGRAM" #welcoming message
echo "YOU WILL NEED TO SPECIFY THE TIME DURING WHICH ARCIHIVING SHOULD ME DONE" #instruction
echo "DEFAULT IS ARCHIVING EVERY SINGLE MINUTE" # information
echo ""

choose_one #calling a funciton which takes user to choose from

variable="$minute $hour $day $month $week (cd /home/image/Documents/Assignments_Year2/Operating_System; ./archive.sh)"

# the variable above stores all the information in a proper syntax for execution from cron tab
# in the syntax fist is the time in order of minute hour day month week and the path to the desired directory
#at last of the syntax is the file name. the file gets executed periodically
# inside the file is the code to zip the directory 
# as a result the directory named Operating System is being archived as the the time user desires. 

			(crontab -l 2>/dev/null; echo "$variable") | crontab - # Writing the above variable in the crontab file 

# Basically crontab runs the file name archive.sh as per the time desired by the user inwhich there is code to zip the directory hence, the directory archives.
