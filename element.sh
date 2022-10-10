
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# declare variables
ATOMIC_NUMBER=0
SYMBOL=''
NAME=''

if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument."
  exit 0
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_NUMBER=$1
elif [[ ${#1} > 2 ]]
then
  NAME=$1
else
  SYMBOL=$1
fi


ELEMENT_RESULT=$($PSQL "select atomic_number, symbol, name, 
  type, atomic_mass, 
  melting_point_celsius, 
  boiling_point_celsius
  from elements 
  join properties 
  using(atomic_number)
  join types 
  using(type_id)
  where atomic_number = $ATOMIC_NUMBER
  or symbol = '$SYMBOL'
  or name = '$NAME'")


if [[ -z $ELEMENT_RESULT ]]
then
  echo "I could not find that element in the database."
else
  echo "$ELEMENT_RESULT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
  do 
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
fi








