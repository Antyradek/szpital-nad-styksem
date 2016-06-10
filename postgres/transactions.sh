# Wypełnienie bazy danych transakcjami opakowanymi w funkcje
DB_NAME=szpital-nad-styksem
USER=postgres

for sql_file in `ls transactions/*.sql`; do 

echo "inserting function: " 
echo $sql_file
psql -U $USER -d $DB_NAME -f "$sql_file"; 

done
