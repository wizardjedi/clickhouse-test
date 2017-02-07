#!/bin/bash

dbname=ch_test
pgpass=123456
pgport=15434

PGPASSWORD=${pgpass} psql -h 127.0.0.1 -p ${pgport} -U postgres
