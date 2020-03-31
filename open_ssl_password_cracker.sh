#! /bin/sh
#
#

#checks whether there is an argument
if [ -z "$1" ]; then
    echo "usage: $0 password"
    exit 1
fi

#extract algorithm type, salt and password
INPUT=$1
echo ""
echo "Input: ${INPUT}"
ALGO=$(echo ${INPUT} | cut -d'$' -f2)
SALT=$(echo ${INPUT} | cut -d'$' -f3)
PASSWORD=$(echo ${INPUT} | cut -d'$' -f4)

echo "------------- START -------------------"
echo "Algorithm $ALGO"
echo "Salt $SALT"
echo "Pass $PASSWORD"

#path to our dictionary
dict="/usr/share/dict/words"
echo ""
echo "using dictionary: ${dict}"
echo ""
echo "hashing words and comparing to the given password"

#reads all words in dict, hashs them and compares to the given password
while read -r p; do
    currentPass=$(openssl passwd -1 -salt "${SALT}" "${p}")
    if [ ${currentPass} = ${INPUT} ]; then
        echo "-------------------------------------"
        echo "Found: $p --> $PASSWORD"
        echo "-------------------------------------"
        break
    fi
done < "${dict}"

#exit the script
#echo "$p --> $PASSWORD"
exit 0
