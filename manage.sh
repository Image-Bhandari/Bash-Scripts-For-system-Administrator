#!bin/bash
# PROGRAM BY : IMAGE BHANDARI
# ASSIGNMENT 2 
# OPERATING SYSTEM MODULE
function option(){ # function option for providing choices to the user regarding what to do
	echo -e " $purple "
	echo "CHOOSE ANY NUMBER FOR THE RESPECTIVE EVENT" #instruction
	echo ""
	echo "ENTER 1 FOR ADDING A USER " #instruction
	echo "ENTER 2 FOR ADDING A GROUP" #instruction
	echo "ENTER 3 FOR DELETING A USER" #instruction
	echo "ENTER 4 FOR DELETING A GROUP" #instruction
	echo "ENTER 5 FOR EDITING A USER" #instruction
	echo "ENTER 6 FOR EDITING A GROUP" #instruction
	echo "ENTER 7 TO EXIT" #instruction
	echo -e " $green "
	read choice
if [[ $choice -eq 1 ]]
then
		new_user # funciton called for adding a new user
elif [[ $choice -eq 2 ]]; then
		new_group # funciton called for adding a new group
elif [[ $choice -eq 3 ]]; then
			del_user #funciton called for deleting a user
elif [[ $choice -eq 4 ]]; then
			del_group #funciton called for deleting a group
elif [[ $choice -eq 5 ]]; then
			edit_user #funciton called for editing user such as changing/ passwords
elif [[ $choice -eq 6 ]]; then
			edit_groups # function called for editing group such as adding a user into it
elif [[ $choice -eq 7 ]]; then
			exit 1		
else
			echo "Invalid input" #for error view
			option # redirecting to the same function to complete the execution
fi

	}

function new_user(){
	echo -e "$yellow Enter User Name : $green" #instruction
	read username  # user inputs
	getent passwd $username > /dev/null  # checking if the name user input already exists or not
if [ $? -eq 0 ]; then # $? is set when you run valid (0) and invalid (1) bash commands.
		echo -e “$red $username exists!” #throwing error message 
		echo "GIVE ANOTHER UNIQUE NAME" #throwing error message 
		new_user # redirecting to the same function to complete the execution
else
		echo -e " $yellow "
		sudo useradd $username #adding the new user with root user permition

		python3 manage.py "USER CREATED A NEW USER NAMED $username"; #writing the event into log file 
		echo "USER $username HAS BEEN CREATED SUCCESSFULLY !"
		echo ""
		option # redirecting to the main menu after the process is completed 

fi
	}

function new_group(){
	echo -e "$yellow Enter Group Name : $green"
	read groupname # taking user input for name for group

if [ $(getent group $groupname) ]  # checking if the name user input already exists or not
then 
	echo -e "$red $groupname ALREADY EXISTS !!" #throwing error message 
	echo -e "PLEASE TRY WITH ANOTHER NAME $green " #throwing error message 
	new_group # redirecting to the same function to complete the execution
else
	echo -e "$green"
	sudo groupadd $groupname #adding the new group with root user permition

	python3 manage.py "USER CREATED A NEW GROUP NAMED $groupname"; # writing the event into log file
	echo " GROUP ADDED SUCCESSFULLY !!"
	echo ""
	option # redirecting to the main menu after the process is completed
fi
	}

function del_user(){
echo -e " $yellow Enter User Name To Delete :"
read del_username # reading user input for username to get deleted
getent passwd $del_username > /dev/null   # checking if the name user input already exists or not
if [ $? -eq 0 ]; then # $? is set when you run valid (0) and invalid (1) bash commands.
	tar cvf $del_username\.tar /home/$del_username
	sudo userdel $del_username #deleting user with root user permition
		python3 manage.py "USER DELETED USER NAMED $username"; #writing the event into log file
		echo -e "$green USER $username HAS BEEN DELETED SUCCESSFULLY !"
		echo "USER BACKUP HAS BEEN CRETED !"
		echo  ""
		option # redirecting to the main menu after the process is completed
	
else
		echo -e “$red $del_username Does not exists!” #throwing error message 
	echo -e "GIVE ANOTHER NAME $green" #throwing error message 
	del_user # redirecting to the same function to complete the execution
fi

}
function del_group(){
	echo -e "$yellow Enter Group Name To Delete: $green"
	read del_groupname # reading user input for group name to get deleted

if [ $(getent group $del_groupname) ]  # checking if the name user input already exists or not
then 
	sudo groupdel $del_groupname #deleting the group with root user permition

		python3 manage.py "USER DELETED GROUP NAMED $groupname"; #writing the event into log file
	echo "Group DELETED SUCCESSFULLY !"
	echo ""
	option # redirecting to the main menu after the process is completed
else
	echo -e "$red No Such Groups" #throwing error message 
	echo -e "Please re-enter the value $green"  #throwing error message 
	del_group  # redirecting to the same function to complete the execution
fi

}

function edit_user(){
	echo -e "$yellow PRESS 1 FOR ADDING / CHANGING PASSWORD TO A USER "
	echo "PRESS 2 FOR PASSWORD MODIFICATION"
	echo -e "PRESS 3 TO VIEW THE USER DETAILS $green"

		python3 manage.py "USER WENT TO EDIT A USER"; #writing the event into log file
	read claim # reading user input for various events
	if [[ $claim =~ 1 ]]; then
		add_password
	elif [[ $claim =~ 2 ]]; then
		modify_password
	elif [[ $claim =~ 3 ]]; then
			view_user
	else
		echo -e "$red Invalid Input" #throwing error message 
		edit_user # redirecting to the same function to complete the execution
	fi


}

function add_password(){
	echo -e "$yellow Enter User Name To change the password : $green"
	read username # reading user input for username to add password
	getent passwd $username > /dev/null   # checking if the name user input already exists or not
if [ $? -eq 0 ]; then # $? is set when you run valid (0) and invalid (1) bash commands.
		sudo passwd $username #adding password to the user with root user permition

		python3 manage.py "USER ADDED PASSWORD FOR $username"; #writing the event into log file
		echo -e "$yellow PASSWORD SUCCESSFULLY CHANGED !!"
		option # redirecting to the main menu after the process is completed
else
		echo -e "$red NO SUCH USERS" #throwing error message 
		echo "PLEASE RE-try" #throwing error message 
		echo ""
		add_password # redirecting to the same function to complete the execution

fi
}
function modify_password(){
	echo -e "$yellow Enter User Name To modify the password : $green"
	read username  # reading user input for username to modify password
	getent passwd $username > /dev/null   # checking if the name user input already exists or not
if [ $? -eq 0 ]; then # $? is set when you run valid (0) and invalid (1) bash commands.
		sudo chage $username #modification of a user's password with root user permition
		echo -e "$yellow PASSWORD MODIFIED SUCCESSFULLY !!"
		python3 manage.py "USER MODIFIED PASSWORD FOR $username"; #writing the event into log file


		option # redirecting to the main menu after the process is completed
else
		echo -e "$red NO SUCH USERS" #throwing error message 
		echo "PLEASE RE-try" #throwing error message 
		echo ""
		modify_password # redirecting to the same function to complete the execution

fi
}

function view_user(){
	echo -e "$yellow Enter User Name To modify the password :"
	read username  # reading user input for username to view the user details
	getent passwd $username > /dev/null   # checking if the name user input already exists or not
if [ $? -eq 0 ]; then # $? is set when you run valid (0) and invalid (1) bash commands.
		sudo chage -l $username #viewing user details with root user permition
		python3 manage.py "USER VIEWED DETAILS OF $username"; #writing the event into log file

		option # redirecting to the main menu after the process is completed
else
		echo -e "$red NO SUCH USERS" #throwing error message 
		echo "PLEASE RE-try" #throwing error message 
		echo ""
		view_user # redirecting to the same function to complete the execution

fi
}

function edit_groups(){
	echo -e "$yellow Press 1 for adding a user onto a group"
	read press # reading user input for desired event
	if [[ $press -eq 1 ]];then
		choose_user_and_group
	else 
		echo "WRONG INPUT"
		echo " PLEASE INPUT A VALID NUMBER !"
		edit_groups # redirecting to the same function to complete the execution
	fi
}

function choose_user_and_group(){
	echo -e "$green Enter User Name :"
	read unique  # reading user input for username 
	getent passwd $unique > /dev/null   # checking if the name user input already exists or not
if [ $? -eq 0 ]; then # $? is set when you run valid (0) and invalid (1) bash commands.
		verify_group
		
else
	echo “$unique does not exists!” #throwing error message 
		echo -e "$red GIVE ANOTHER  NAME" #throwing error message 
		choose_user_and_group # redirecting to the same function to complete the execution

fi
}

function verify_group(){
	echo -e "$yellow Enter Group Name : $green"
	read groupname # reading user input for group name

if [ $(getent group $groupname) ]  # checking if the name user input already exists or not
then 
	sudo usermod -a -G $groupname $unique #adding the user to a group with root user permition
	echo -e "$yellow $unique has been SUCCESSFULLY added into $groupname.."
	python3 manage.py "USER ADDED $unique TO THE GROUP $groupname"; #writing the event into log file

	option # redirecting to the main menu after the process is completed
else
	echo -e " $red No such Group" #throwing error message 
	echo "Please enter a valid group name" #throwing error message 
	echo ""
	verify_group # redirecting to the same function to complete the execution
	
fi
}

#Initialization of required color 
red='\033[1;31m' #red font color
green='\033[1;32m' #green font color
yellow='\033[1;33m' #yellow font color
purple='\033[1;35;52m' #purple font color
clear #program begains from this point..

python3 manage.py " "; # starts writing a log file 
python3 manage.py "USER ENTERED INTO THE PROGRAM"; # writing into a log file
echo -e "$yellow  ~~WELCOME TO THE PROGRAM FOR MODIFICATION OF USERS AND GROUPS~~" #welcome text
echo ""
option #funciton called to choose a opiton