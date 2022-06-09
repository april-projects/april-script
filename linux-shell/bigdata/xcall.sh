#!/bin/bash
for host in alihadoop101 alihadoop102 alihadoop103
do
        echo =============== $host ===============
        ssh $host $@ 
done
