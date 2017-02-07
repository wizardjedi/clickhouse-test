#!/bin/bash

docker run -i --rm --link some-clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server clickhouse-client $@
