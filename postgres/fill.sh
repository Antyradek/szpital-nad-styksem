# Wypełnienie bazy danymi
DB_NAME=szpital-nad-styksem
USER=postgres

: ' 
for sql_file in `ls fill/*.sql`; do 

echo "processing: " 
echo $sql_file
psql -U $USER -d $DB_NAME -f "$sql_file"; 

done
'

cd fill/
psql -U $USER -d $DB_NAME -f fillEnums.sql;
psql -U $USER -d $DB_NAME -f fillOsoby.sql;
psql -U $USER -d $DB_NAME -f fillLekarzeRodzinni.sql;
psql -U $USER -d $DB_NAME -f fillPacjenci.sql;
psql -U $USER -d $DB_NAME -f fillPracownicy.sql;
psql -U $USER -d $DB_NAME -f fillOddzialy.sql;
psql -U $USER -d $DB_NAME -f fillLozka.sql;
psql -U $USER -d $DB_NAME -f fillHospitalizacje.sql;
psql -U $USER -d $DB_NAME -f fillHospitalizacjeAmbulatoryjne.sql;
psql -U $USER -d $DB_NAME -f fillPacjenciOczekujacy.sql;
psql -U $USER -d $DB_NAME -f fillWizyty.sql;
psql -U $USER -d $DB_NAME -f fillPracownicyNaOddziale.sql;
psql -U $USER -d $DB_NAME -f fillZatrudnienia.sql;
psql -U $USER -d $DB_NAME -f fillKwalifikacje.sql;
psql -U $USER -d $DB_NAME -f fillDoswiadczeniaZawodowe.sql;
psql -U $USER -d $DB_NAME -f fillMaterialy.sql;
psql -U $USER -d $DB_NAME -f fillLeki.sql;
psql -U $USER -d $DB_NAME -f fillDozowaniaLeku.sql;
psql -U $USER -d $DB_NAME -f fillDostawcy.sql;
psql -U $USER -d $DB_NAME -f fillDostawy.sql;
psql -U $USER -d $DB_NAME -f fillPokrewienstwa.sql;
psql -U $USER -d $DB_NAME -f fillFormularzeZapotrzebowania.sql;
psql -U $USER -d $DB_NAME -f fillPozycjeZamowienia.sql;
