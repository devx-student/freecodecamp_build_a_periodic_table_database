#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"
if [[ $1 == '' ]]
then
  echo Please provide an element as an argument.
elif [[ $1 =~ ^[0-9]*$ ]]
then
  echo $($PSQL "SELECT symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,atomic_number,type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1") | while read SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR NUMBER BAR TYPE
  do
    if [[ -z $NUMBER ]]
    then
      echo I could not find that element in the database.;
    else
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    fi
  done
else
  echo $($PSQL "SELECT symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,atomic_number,type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE lower(name) = LOWER('$1') OR lower(symbol) = LOWER('$1')") | while read SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR NUMBER BAR TYPE
  do
    if [[ -z $NUMBER ]]
    then
      echo I could not find that element in the database.;
    else
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    fi
  done
fi
