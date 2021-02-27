
if [ -f "$(pwd)/.env" ]; then
    cp ".env.dist" ".env";
    printf "File .env created. You must fill config data! \n"
fi
