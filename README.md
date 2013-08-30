Client - Server
===============

Client:

    { command: 'connect', value: {x: 23, y: 34, height: 640, width: 480} }

Server:

    { time: 1377880167.008842, positions: [{ x: 20, y: 30, dx: 4, dy 5}]}


Booting servers
================

server:

    cd server
    ruby server.rb

client:

    cd client
    bundle exec middleman server


Then visit:

    http://localhost:4567/


