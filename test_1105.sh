#!/bin/bash

WORKDIR=/home/user/tests/workdir/testdir_1105
BASEDIR=/home/user/tests/workdir/base_scripts
PORT1=8012 # change the number of PORT1 here
PORT2=8013 # change the number of PORT2 here
WAITS1=4 # change the WAITS1 here

trap 'rm -f "$WORKDIR"/PeoplePass.postman_environment.json' EXIT

mkdir -p $WORKDIR/logs

cp $BASEDIR/PeoplePass.postman_environment.json $WORKDIR

sed -i -e "s/PORT1/${PORT1}/g; s/PORT2/${PORT2}/g; s/WAITS1/${WAITS1}/g" $WORKDIR/PeoplePass.postman_environment.json

cd $WORKDIR && newman run PeoplePass.postman_collection.json --timeout-request 30000 --delay-request 1000 -e PeoplePass.postman_environment.json -d monpass-2.csv >> $WORKDIR/logs/test_1105.txt
