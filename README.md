Repository for testing Yandex ClickHouse database vs PostgreSQL

# Create containers and import schema to default database
```
$ ./prepare.sh
```

# Generate test data
```
$ composer update
$ php generate-data.php | bzip2 > data.sql.bz2
```

Change number of days of days, rounds or batch size

# Import data to clickhouse

```
$ bzcat data.sql.bz2 | ./ch.sh -n
```

# Import data to PostgreSQL

```
$ bzcat data.sql.bz2 | ./pg.sh
```

# Run consoles

Run console for ch in one window

```
$ ./clickhouse.sh 
ClickHouse client version 1.1.54140.
Connecting to clickhouse-server:9000.
Connected to ClickHouse server version 1.1.54140.

:) 
```

Run console for pg in other window

```
$ ./pg.sh 
psql (9.4.8, server 9.5.1)  
Type "help" for help.

postgres=# 
```

Use `\timing` command for psql to turn on timings.

# Try queries

|query|ClickHouse|PostgreSQL|
|---|---|---|
|`select count(*) from statistics;`|0.01|0.264|
|`select count(distinct abonent) from statistics;`|0.051|1.586|
|`select count(*), count(distinct operator_id), count(distinct region_id), count(distinct abonent), count(distinct send_name_id) from statistics;`|0.111|6.595|
|`select count(*) from statistics where EventDate>'2016-05-05' and EventDate<'2016-07-05' and partner_id in (1,10,15,25,900);`|0.007|0.52|
| * ch:`select toMonth(EventDate), sum(sms_send_count), sum(sms_delivered_count) from statistics group by toMonth(EventDate);`|0.047|-|
| * pg:`select extract(month from EventDate), sum(sms_send_count), sum(sms_delivered_count) from statistics group by extract(month from EventDate);`|-|0.986|
|`select region_id, sum(sms_send_count) from statistics group by region_id order by count(*) limit 10;`|0.028|0.688|
