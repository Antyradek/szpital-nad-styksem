# Wypełnienie bazy danymi
DB_NAME=szpital-nad-styksem
USER=postgres

for sql_file in `ls fill/*.sql`; do psql -U $USER -d $DB_NAME -f $sql_file; done
