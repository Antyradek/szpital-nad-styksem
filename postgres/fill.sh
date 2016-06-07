# Wypełnienie bazy danymi
DB_NAME=szpital-nad-styksem
USER=postgres

for sql_file in `ls fill/*.sql`; do 

echo "processing: " 
echo $sql_file
psql -U $USER -d $DB_NAME -f "$sql_file"; 

done
