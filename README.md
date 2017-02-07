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

# Import data to PotgreSQL

```
$ bzcat data.sql.bz2 | ./pg.sh
```
