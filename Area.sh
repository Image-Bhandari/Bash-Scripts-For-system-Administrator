#!bin/bash
#Program By: Image Bhandari
#Uon ID: 18413643
#Assignemnt 2
#This program is for calculating the area of a rectangle by accepting length and breath from user, converting into meter and inches , calculating respective area using basic calculator and outputing the result in clear way

read_length(){ # creating a function for input length and verification
echo -e "$green Enter The Length Of Rectangle(in centimeters): " # user interaction
read length # leting user to input length and storing it in a variable
if [[ $length =~ ^[0-9]*?$ ]] || [[ $length =~ ^[0-9]*?+\.[0-9]*?$ ]] && [[ $length != '0' ]] # verifing the length is a interger and not a single 0 digit
	then
		python3 areaLog.py "User enter the Length of rectangle: $length";
		read_breath #calling a function for reading breath
else
	echo -e "$red Please Input A Valid Number" # error display
	echo ""
	read_length # recalling the same function
fi
}
read_breath(){ # creating a function for input breath and verification
echo -e "$green Enter The Breath Of Rectangle(in centimeters): " # user interaction
read breath # leting user to input breath and storing it in a variable
if [[ $breath =~ ^[0-9]*?+\.[0-9]*?$ || $breath =~ ^[0-9]*?$ ]] && [[ $breath != '0' ]] # verifing the breath is a interger and not a single 0 digit
	then
		python3 areaLog.py "User enter the BREATH of rectangle: $breath";
		lengthToInches=$(bc -l<<< "$length/2.54") #converting length of cm into inches
		lengthToMetres=$(bc -l<<< "$length/100")  #converting length of cm into meters
		breathToInches=$(bc -l<<< "$breath/2.54") #converting breath of cm into inches
		breathToMetres=$(bc -l<<< "$breath/100")  #converting breath of cm into meters
		echo -e "$yellow The area of rectangle in Inches Square is : " $(bc <<< "scale=4; $lengthToInches*$breathToInches") #calculating the area of rectangle using basic calculator for meter square
		echo " The area of rectangle in Metres Square is : " $(bc <<< "$lengthToMetres*$breathToMetres") #calculating the area of rectangle using basic calculator for meter square
		re_do
	else
echo -e "$red Please Input A Valid Number" # error display
echo ""
read_breath # recalling the same function incase of error
fi
}
re_do(){ #creating a function for resuming the calculation
	echo -e "$purple RESUME THE PROCESS ??" # asking if the user wants to resume the process
	echo -e " PRESS $red Y $purple TO RESUME OR $red ANY OTHER $purple TO EXIT" # if the user wants to resume then press y else press any
	read decision # reading the user decision if user wants to resume or not
	if [[ $decision =~ 'Y' ]] || [[ $decision =~ 'y' ]] # checking the decision 
	then
		python3 areaLog.py "User Resumed the program";
	read_length # if decision is yes then recalling the function from the start
    else
    	python3 areaLog.py "User Exited";
    	echo -e " \t\t\t\t THANK YOU !! " # thankyou message while leaving the program. 
    fi
}

#Initialization of required color 
red='\033[1;31m' #red font color
green='\033[1;32m' #green font color
yellow='\033[1;33m' #yellow font color
purple='\033[1;35;52m' #purple font color
clear #program begains from this point..
echo -e "$green ~~ \t\t CALCULATING THE  AREA OF A RECTANGLE \t\t ~~" # Welcoming text
echo ""
python3 areaLog.py "User Entered into the program";
read_length # calling function for reading length of the rectangle

