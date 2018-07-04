#!/bin/sh

cd /Users/sandro/dev/workspace/feira5

pid="tmp/pids/server.pid"

if [ -e "$pid" ]
then
  echo "Killing PID: $(cat $pid)"
  kill -TERM $(cat $pid)
fi

rails server -b 0.0.0.0 -p 3000 -e production
