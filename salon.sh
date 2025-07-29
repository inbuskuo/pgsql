#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

echo -e "Welcome to My Salon, how can I help you?\n"


MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
TAKE_SERVICES=$($PSQL "select * from services")
echo "$TAKE_SERVICES" | while  IFS="|" read ID NAME
do
echo "$ID) $NAME"
done

# read input service
read SERVICE_ID_SELECTED
#search service exist
CHECK_SERVICE_NAME=$($PSQL "select name from services where service_id = '$SERVICE_ID_SELECTED'")
if [[ -z $CHECK_SERVICE_NAME ]]
then
# service not find
MAIN_MENU "I could not find that service. What would you like today?"
else
#service find
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
CHECK_PHONE_FOR_NAME=$($PSQL "select name from customers where phone = '$CUSTOMER_PHONE'")
  # check phone exist
  if [[ -z $CHECK_PHONE_FOR_NAME ]]
  then
  #don't having phone
  echo -e "\nI don't have a record for that phone number, what's your name?"
  #check name
  read CUSTOMER_NAME

    # ask for service time
    echo -e "\nWhat time would you like your $CHECK_SERVICE_NAME,$CUSTOMER_NAME?"
    read SERVICE_TIME
    #input record
    # input customer first
    INPUT_CISTOMER=$($PSQL "insert into customers(phone,name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    INPUT_CUSTOMER_ID=$($PSQL "select customer_id from customers where name = '$CUSTOMER_NAME'")
    # input appointments
    INPUT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values('$INPUT_CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
    echo -e "I have put you down for a $CHECK_SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  else
  #having phone
  echo -e "What time would you like your '$CHECK_SERVICE_NAME','$CHECK_PHONE_FOR_NAME'"
  read SERVICE_TIME
    INPUT_CUSTOMER_ID=$($PSQL "select customer_id from customers where name = '$CHECK_PHONE_FOR_NAME'")
   # input appointments
    INPUT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values('$INPUT_CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
    echo -e "I have put you down for a $CHECK_SERVICE_NAME at $SERVICE_TIME, $CHECK_PHONE_FOR_NAME."
  fi
  #check phone exist end

fi
# list all service end

}



MAIN_MENU