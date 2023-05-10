sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.*: //'
