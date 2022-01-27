## checking to see which containers I have
docker container ls

## opens up the bash shell command line
docker container exec -it PostgreHome /bin/bash

## won't work from the shell
pg_dump postgrelearning > butest1;
## will also error from the command line
## because it runs under context of my login

##So...
pg_dump -U postgres postgrelearning > butest1;
## in bash, it runs
## from powershell, it demands a password for the login


pg_dump -h hsrpostgres.postgres.database.azure.com -U grant@hsrpostgres hamshackradio > hsr

pg_dump --dbname=postgresql://grant:$cthulhu1988@hsrpostgres.postgres.database.azure.com:5432/hamshackradio > hsr

pg_dump -Fc --host=hsrpostgres.postgres.database.azure.com --username=grant@hsrpostgres hamshackradio > hsr
pg_dump --host=hsrpostgres.postgres.database.azure.com --username=grant@hsrpostgres hamshackradio > hsr2



## setting up WAL archiving
## first, go to bash
docker container exec -it PostgreHome /bin/bash

## open the vi editor
vi /var/lib/postgresql/data/postgresql.conf

## supply the following
wal_level = replica
archive_mode = on
archive_command = 'test ! -f /mnt/server/archivedir/%f && cp %p /mnt/server/archivedir/%f'


## restart the server
docker restart PostgreHome


## back into bash and then
pg_basebackup -U postgres -D /bu

