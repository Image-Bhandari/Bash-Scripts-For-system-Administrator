#!/bin/bash
#
# CALCULATING THE  SALES BONUS PROGRAM
# PROGRAM BY : IMAGE BHANDARI
# ASSIGNMENT 2 
# OPERATING SYSTEM MODULE


declare -a name 
declare -a sales
declare -a bonus
a=0
user=1
enough=0

check_username(){ # funciton for checking username and validation 
	echo " This is User $user" 
	echo -e "$green Give your name to check bonus: "
	read username # reading the length 
	if [[ $username =~ ^[A|a-Z|z]*?$ ]] # validation of the input length
	then
	name[$a]=$username # if correct then storing in array
	python3 salesLog.py "User enter the name: $username"; # declaringin the script file
else
	echo -e "$red Invalid Username" # error message if the name is not valid
	echo -e "Please Re-Enter the value $green" # error message
	check_username # redirecting to the fucntion 
fi
}

check_sales(){
	echo -e "$yellow" 
	echo ""
	echo "BONUS INFO: "
	echo " FOR SALES LESS THAN 99,999 BONUS IS 0 " # BONUS INFO
	echo " FOR SALES BETWEEN 100,000 AND 999,999 BONUS IS 750 " # BONUS INFO
	echo " FOR SALES MORE THAN 1,000,000 BONUS IS 1,500 " # BONUS INFO
	echo "" # BONUS INFO
	echo ""
	echo -e "$green Give sales of $red $username $green to check bonus : "
	read money #Reading the amount of income
	if [[ $money =~ ^[0-9]*?+\.[0-9]*?$ || $money =~ ^[0-9]*?$ ]] && [[ $money != '0' ]] # validation if the amount is integer and a decimal 
		then
	sales[$a]=$money # strong if the condition is true
	python3 salesLog.py "$username has  income : $money"; # writingthe data to the log file
else
	echo -e "$red Invalid Amount" # error  message
	echo "Please Re-Enter the value" # error message
	check_sales # redirecting to the same function
fi
}

check_bonus(){ # function for checking the bounus

		echo $money # checking the above entered value
		if [[ "$money" -ge 1000000 ]]; # condition if the money is greater than 1000000 then bonus is 1500
		then
			bonus[$a]=`echo $money+1500 | bc`


		elif [[ "$money" -ge 100000 ]]; # condition if the money is greater than 100000 then bonus is 1500
		then
				bonus[$a]=`echo $money+750 | bc`

		else # condition if the money is less than no bonus
					bonus[$a]=`echo $money+0 | bc`
		fi

		echo "bonus is ${bonus[$a]}" # displaying the bonus for each entry 
		python3 salesLog.py "$username has bonus ${bonus[$a]}"; # writing the bonus in log file
}

re_do(){ # function that resume all the above procedure
	echo ""
	echo -e "$yellow ANY OTHER INPUT ??" #asking for resuming the procedure
	echo -e "$green PRESS $red Y $green IF ANY OR $red ANY OTHER $green TO EXIT"
	read decision # reading the user decision 
	if [[ $decision =~ 'Y' ]] || [[ $decision =~ 'y' ]] # if user inputs y then only the process resumes
	then
	a=$(echo "$a+1" | bc) # increasing the number of user in array
	user=$(echo "$user+1" | bc) # increasing the number of user
	enough=0
	
    else
    enough=1 # boolean for exiting from the input section
    fi
}

ordering(){ # functoin which orders the output desired by the user
echo "In which order would you like to display the bonus?"
echo "1. In alphabetical assending order "
echo "2. From less amount to high "
echo "3. As user gave input"
read option # reading user input
if [[ $option =~ '1' ]]; # checking the input if its 1
then
	echo "This is alphabet assending order"
	bubble_sort_by_name # fucntion for displaying the name in alphabet order
elif [[ $option =~ '2' ]]; then # checking the input if its 2
	echo "This is by amount"
	bubble_sort_by_amount # fucntion for displaying amount in assending order
elif [[ $option =~ '3' ]]; then  # checking the input if its 3
	echo ${name[@]}  # displaying in original order
	echo ""
	echo ${sales[@]} # displaying in original order
	echo ""
	echo ${bonus[@]} # displaying in original order
	echo "" 
	echo ""
echo ""

	else
		echo "Invalid input" # error message
		echo "Please re-enter the value either 1 or 2 " # error message
		ordering # recalling the same funciton
fi
}

bubble_sort_by_name(){
for ((i=0; $i<${#name[@]}; i=$i+1)) # loop for the number of elements in that perticular array
do
    for((j=0; $j<${#name[@]}-1; j=$j+1)) # loop until the second last digit
    do
        if [[ "${name[$j]}" > "${name[$(($j+1))]}" ]]; # checking if an index is greater than the one next to it
        then
        	o=$j # initialization
        	z=$j # initialization
            swap_value=${sales[$j]} # swapping the index into an variable
            sales[$j]=${sales[$(($j+1))]} # swapping the index into another index next to it 
            sales[$(($j+1))]=$swap_value # swapping the variable value into the previous index...

            swap_name=${name[$o]} # swapping the index into an variable
            name[$o]=${name[$(($o+1))]}    # swapping the index into another index next to it 
            name[$(($o+1))]=$swap_name

            swap_bonus=${bonus[$z]} # swapping the index into an variable
            bonus[$z]=${bonus[$(($z+1))]}    # swapping the index into another index next to it 
            bonus[$(($z+1))]=$swap_bonus  # swapping the variable value into the previous index...
        fi
    done
done 
echo ""
echo ""

}

bubble_sort_by_amount(){
for ((i=0; $i<${#sales[@]}; i=$i+1)) # loop for the number of elements in that perticular array
do
    for((j=0; $j<${#sales[@]}-1; j=$j+1))  # loop until the second last digit
    do
        if [[ "${sales[$j]}" < "${sales[$(($j+1))]}" ]]; # checking if an index is greater than the one next to it
        then
        	o=$j # initialization
        	z=$j # initialization
            swap_value=${sales[$j]}  # swapping the index into an variable
            sales[$j]=${sales[$(($j+1))]}  # swapping the index into another index next to it  
            sales[$(($j+1))]=$swap_value # swapping the variable value into the previous index...

            swap_name=${name[$o]}  # swapping the index into an variable
            name[$o]=${name[$(($o+1))]}   # swapping the index into another index next to it 
            name[$(($o+1))]=$swap_name # swapping the variable value into the previous index...

            swap_bonus=${bonus[$z]}  # swapping the index into an variable
            bonus[$z]=${bonus[$(($z+1))]}  # swapping the index into another index next to it  
            bonus[$(($z+1))]=$swap_bonus # swapping the variable value into the previous index...
        fi
    done
done 
echo ""
echo ""

}




#
#
# START OF THE FLOW OF PROGRAM 
#
#
red='\033[1;31m' #red font color
green='\033[1;32m' #green font color
yellow='\033[1;33m' #yellow font color
purple='\033[1;35;52m' #purple font color
clear #program begains from this point..
echo -e "$yellow WELCOME IN SALES CALCULATION" # welcoming message at the beginning
python3 salesLog.py "User Entered The Program"; # welcoming message in script

until [[ $enough = 1 ]]; do #while loop implementation for repeatedly taking input
	check_username # calling funciton for taking name and validation
	check_sales # calling funciton for taking amount and validation
	check_bonus # calling function for calculating the bonus
	re_do # calling functoin for retaking the input of a person
done
ordering # calling function for desire of the user to display the input datas


echo "NAME: " ${name[@]} # printing the names in order
echo ""
echo "SALARY: "${sales[@]} # printing the sales in order
echo ""
echo "T.BONUS: "${bonus[@]} # printing the bonus in order
echo ""

