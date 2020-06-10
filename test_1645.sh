#!/bin/bash

WORKDIR=/home/user/tests/workdir/testdir_1645
BASEDIR=/home/user/tests/workdir/base_scripts
PORT1=8020 # change the number of PORT1 here
PORT2=8021 # change the number of PORT2 here
WAITS1=2 # change the WAITS1 here

trap 'rm -f "$WORKDIR"/PeoplePass.postman_environment.json' EXIT

mkdir -p $WORKDIR/logs

cp $BASEDIR/PeoplePass.postman_environment.json $WORKDIR

sed -i -e "s/PORT1/${PORT1}/g; s/PORT2/${PORT2}/g; s/WAITS1/${WAITS1}/g" $WORKDIR/PeoplePass.postman_environment.json

cd $WORKDIR && newman run PeoplePass.postman_collection.json --timeout-request 30000 --delay-request 600 -e PeoplePass.postman_environment.json -d evnpass-3.csv >> $WORKDIR/logs/test_1645.txt

