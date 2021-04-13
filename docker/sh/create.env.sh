
FILE=$(pwd)/.env

echo "file: $FILE";

if [ ! -f "$FILE" ]; then
    cp ".env.dist" $FILE;
    printf "The file has created. You should to fill config data! \n"
else
    echo "The file already exist."
fi
