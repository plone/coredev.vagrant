#!/bin/sh

echo "Killing all running Plone instances"
for instance in `ps x | grep buildout.coredev | grep -v grep | egrep -o "^ *[0-9]+"`
do
    echo Killing $instance
    kill $instance
done
