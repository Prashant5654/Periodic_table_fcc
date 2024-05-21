#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo  "Please provide an element as an argument."
  exit
fi
if [[ $1 =~ ^[1-9]+$ ]]
then 
   element_data=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where atomic_number='$1'")
else
#if argument is string
  element_data=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where name = '$1' or symbol = '$1'")
fi
if [[ -z $element_data ]]
then 
echo  "I could not find that element in the database."
exit
fi

echo $element_data | while IFS=" |" read atomic_number name symbol type atomic_mass melting_point_celsius  boiling_point_celsius 
do

 echo  "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
 
done 
