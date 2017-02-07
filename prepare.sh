#!/bin/bash

containername_psql=ch_postgres 
containername_ch=ch_clickhouse 
dbname=ch_test
pgpass=123456
pgport=15434

echo "Clean up previous containers"

docker ps | grep ${containername_psql} && docker kill ${containername_psql}
docker ps -a | grep ${containername_psql} && docker rm ${containername_psql}
docker ps | grep ${containername_ch} && docker kill ${containername_ch}
docker ps -a | grep ${containername_ch} && docker rm ${containername_ch}

set -e

echo "Run docker container with name ${containername_psql}"
docker run -d --name ${containername_psql} -e POSTGRES_PASSWORD=${pgpass} -p ${pgport}:5432 postgres

echo "Wait maximum 30 seconds for Postgres..."

i=0

until PGPASSWORD=${pgpass} psql -h 127.0.0.1 -p ${pgport} -U postgres -c "SELECT 1;" &> /dev/null ; do
        sleep 1
        echo -n "."
        i=$[$i+1]
        if [ "$i" -ge "30" ];then
                echo -e "\e[1;31mFailed\e[0m"
                echo "Postgresql not started in 10 seconds...Check logs..."
                exit 1
        fi
done

echo -e "\nCreate schema"

PGPASSWORD=${pgpass} psql -h 127.0.0.1 -p ${pgport} -U postgres < schema/ps.sql

echo -e "\nRun container with name ${containername_ch}"

docker run -d --name some-clickhouse-server --ulimit nofile=262144:262144 yandex/clickhouse-server

echo -e "\n Import schema\n"

cat schema/ch.sql | ./ch.sh -n
