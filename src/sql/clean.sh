vartest=`psql -X -U postgres -h localhost -t -c "select datname from pg_database where datistemplate = false and datname LIKE 'ccdd%' and datname <> (select datname from pg_database where datistemplate = false and datname like 'ccdd%' ORDER BY datname DESC LIMIT 1);"`
echo $vartest;
