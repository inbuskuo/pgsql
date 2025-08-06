#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN_FUNC(){
  echo "Enter your username:"
  read NAME

  if [[ -z $NAME ]]
  then
    MAIN_FUNC
  else
    TRIM_NAME=$( echo $NAME | sed 's/ //g')
    USER_NAME=$($PSQL "SELECT username FROM users WHERE username='$TRIM_NAME';")
    #check user in db
    if [[ -z $USER_NAME ]]
    then
      USER_NAME=$TRIM_NAME
      echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
    else
      USER_ID=$(echo $($PSQL "SELECT user_id FROM users WHERE username='$USER_NAME';") )
      USER_NAME=$(echo $($PSQL "SELECT username FROM users WHERE user_id='$USER_ID';") )
      GAME_PLAYED=$(echo $($PSQL "SELECT games_played FROM users WHERE user_id=$USER_ID;") )
      BEST_GAME=$(echo $($PSQL "SELECT MIN(best_game) FROM users LEFT JOIN games USING(user_id) WHERE user_id=$USER_ID;"))
      echo "Welcome back, $USER_NAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
    fi  
    #check user in db
    #call next func
    CORRECT_ANSWER=$(( $RANDOM % 1000 + 1 ))
    GUESS_COUNT=0
    INPUT_GUESS $USER_NAME $CORRECT_ANSWER $GUESS_COUNT
    #call next func
  fi

}


INPUT_GUESS() {
  USER_NAME=$1
  CORRECT_ANSWER=$2
  GUESS_COUNT=$3
  USSER_GUESS=$4

  if [[ -z $USSER_GUESS ]]
  then
    echo "Guess the secret number between 1 and 1000:"
    read USSER_GUESS
  else
    #If anything other than an integer is input as a guess, it should print That is not an integer, guess again:
    echo "That is not an integer, guess again:"
    read USSER_GUESS
  fi

  GUESS_COUNT=$(( $GUESS_COUNT + 1 ))
  if [[ ! $USSER_GUESS =~ ^[0-9]+$ ]]
  then
    INPUT_GUESS $USER_NAME $CORRECT_ANSWER $GUESS_COUNT $USSER_GUESS
  else
    CHECK_ANSWER $USER_NAME $CORRECT_ANSWER $GUESS_COUNT $USSER_GUESS
  fi
}

CHECK_ANSWER() {
  USER_NAME=$1 
  CORRECT_ANSWER=$2 
  GUESS_COUNT=$3
  USSER_GUESS=$4
  
  if [[ $USSER_GUESS -lt $CORRECT_ANSWER ]]
  then
    echo "It's lower than that, guess again:"
    read USSER_GUESS
  elif [[ $USSER_GUESS -gt $CORRECT_ANSWER ]]
  then
    echo "It's higher than that, guess again:"
    read USSER_GUESS
  else
    GUESS_COUNT=$GUESS_COUNT
  fi

  GUESS_COUNT=$(( $GUESS_COUNT + 1 ))
  if [[ ! $USSER_GUESS =~ ^[0-9]+$ ]]
  then
    INPUT_GUESS $USER_NAME $CORRECT_ANSWER $GUESS_COUNT $USSER_GUESS
  elif [[ $USSER_GUESS -lt $CORRECT_ANSWER ]] || [[ $USSER_GUESS -gt $CORRECT_ANSWER ]]
  then
    CHECK_ANSWER $USER_NAME $CORRECT_ANSWER $GUESS_COUNT $USSER_GUESS
  elif [[ $USSER_GUESS -eq $CORRECT_ANSWER ]]
  then
    SAVE_USER $USER_NAME $GUESS_COUNT
    NUMBER_OF_GUESSES=$GUESS_COUNT
    SECRET_NUMBER=$CORRECT_ANSWER
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi

}

SAVE_USER() {
  USER_NAME=$1 
  GUESS_COUNT=$2

  CHECK_NAME=$($PSQL "SELECT username FROM users WHERE username='$USER_NAME';")
  if [[ -z $CHECK_NAME ]]
  then
    INSERT_NEW_USER=$($PSQL "INSERT INTO users(username, games_played) VALUES('$USER_NAME',1);")
  else
    GET_GAME_PLAYED=$(( $($PSQL "SELECT games_played FROM users WHERE username='$USER_NAME';") + 1))
    UPDATE_EXIST_USER=$($PSQL "UPDATE users SET games_played=$GET_GAME_PLAYED WHERE username='$USER_NAME';")
  fi
  SAVE_GAME $USER_NAME $GUESS_COUNT
}

SAVE_GAME() {
  USER_NAME=$1 
  NUMBER_OF_GUESSES=$2

  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USER_NAME';")
  INSERT_GAME=$($PSQL "INSERT INTO games(user_id, best_game) VALUES($USER_ID, $NUMBER_OF_GUESSES);")
  USER_NAME=$($PSQL "SELECT username FROM users WHERE user_id=$USER_ID;")
}


MAIN_FUNC