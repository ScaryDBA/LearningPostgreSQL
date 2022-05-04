docker exec -it PostgreHome "bash" 
docker exec -it PostgreHome sh

## change user in bash or shell
su postgres

##commands to run in bash
##WAL storage walarchive
mkdir walarchive
##DB storage dbarchive
mkdir dbarchive

##change security
chown postgres:postgres walarchive
chown postgres:postgres dbarchive

find / -name "postgresql.conf"

##open vim to edit postgresql.conf
vim /var/lib/postgresql/data/postgresql.conf

## inser to edit. escape to stop. :w to write, :q to quit

archive_command = 'test ! -f /walarchive/%f $$ cp %p /walarchive/%f'

## restart the container is one way
docker restart PostgreHome

##


## base backup
pg_basebackup -D \dbarchive

## base backup with compression, progress and a label
pg_basebackup -D \dbarchive -P -l "Learning PostgreSQL With Grant Backup" -F tar -z

## to restore to a point in time
## connect through bash and change to postgres user
## stop the server
pg_ctl stop

rm data
mkdir data

