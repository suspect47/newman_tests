#!/bin/bash

WORKDIR=/home/user/tests/workdir/testdir_1045
BASEDIR=/home/user/tests/workdir/base_scripts
PORT1=8012 # change the number of port here (for PeoplePass1.postman_environment.json and PeoplePass2.postman_environment.json)
PORT2=8013 # change the number of port here (for PeoplePass3.postman_environment.json and PeoplePass4.postman_environment.json)

trap 'rm -f "$WORKDIR"/PeoplePass{1,2,3,4}.postman_environment.json' EXIT

mkdir -p $WORKDIR/logs
cp $BASEDIR/PeoplePass{1,2,3,4}.postman_environment.json $WORKDIR

sed -i -e "s/PORT/${PORT1}/g" $WORKDIR/PeoplePass1.postman_environment.json
sed -i -e "s/PORT/${PORT1}/g" $WORKDIR/PeoplePass2.postman_environment.json
sed -i -e "s/PORT/${PORT2}/g" $WORKDIR/PeoplePass3.postman_environment.json
sed -i -e "s/PORT/${PORT2}/g" $WORKDIR/PeoplePass4.postman_environment.json

cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 1000 -e PeoplePass1.postman_environment.json -d mon200-1.csv >> $WORKDIR/logs/test_1045_1.txt & \
cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 1000 -e PeoplePass2.postman_environment.json -d mon200-2.csv >> $WORKDIR/logs/test_1045_2.txt & \
cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 1000 -e PeoplePass3.postman_environment.json -d mon200-3.csv >> $WORKDIR/logs/test_1045_3.txt & \
cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 1000 -e PeoplePass4.postman_environment.json -d mon200-4.csv >> $WORKDIR/logs/test_1045_4.txt
