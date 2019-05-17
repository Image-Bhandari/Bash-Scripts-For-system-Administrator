import sys  # importing from sys library 
f=open("salesLog.txt","a+") # creates a file, if file exists then over writes the file
f.write(sys.argv[1]+"\n"); #writes the line send from the script to the txt file