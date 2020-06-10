#!/bin/bash

BASEDIR=/home/user/tests/workdir/base_scripts
WORKDIR=/home/user/tests/workdir/testdir_1440
PORT1=8012 # change the number of port here (for PeoplePass1.postman_environment.json and PeoplePass2.postman_environment.json)
PORT2=8013 # change the number of port here (for PeoplePass3.postman_environment.json and PeoplePass4.postman_environment.json)

trap 'rm -f "$WORKDIR"/PeoplePass{1,2,3,4}.postman_environment.json' EXIT

mkdir -p $WORKDIR/logs

cp $BASEDIR/PeoplePass{1,2,3,4}.postman_environment.json $WORKDIR

sed -i -e "s/PORT/${PORT1}/g" $WORKDIR/PeoplePass1.postman_environment.json
sed -i -e "s/PORT/${PORT1}/g" $WORKDIR/PeoplePass2.postman_environment.json
sed -i -e "s/PORT/${PORT2}/g" $WORKDIR/PeoplePass3.postman_environment.json
sed -i -e "s/PORT/${PORT2}/g" $WORKDIR/PeoplePass4.postman_environment.json

cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 600 -e PeoplePass1.postman_environment.json -d dayin200-1.csv >> $WORKDIR/logs/test_1440_1.txt & \
cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 600 -e PeoplePass2.postman_environment.json -d dayin200-2.csv >> $WORKDIR/logs/test_1440_2.txt & \
cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 600 -e PeoplePass3.postman_environment.json -d dayin200-3.csv >> $WORKDIR/logs/test_1440_3.txt & \
cd $WORKDIR && newman run PeoplePassDeterminatedAP.postman_collection.json --timeout-request 30000 --delay-request 600 -e PeoplePass4.postman_environment.json -d dayin200-4.csv >> $WORKDIR/logs/test_1440_4.txt

