Booting servers
===

server:

    cd server
    ruby server.rb

client:

    cd client
    bundle exec middleman server


Then visit:

    http://localhost:4567/


Client - Server Handshake
===

Client connects by sending its initial state:

    { command: 'connect', value: {x: 23, y: 34, height: 640, width: 480} }

Server responds with the state of the current World:

    { time: 1377880167.008842, positions: [{ x: 20, y: 30, dx: 4, dy 5}]}


Creating new objects in the World
====

To create a new ball/entity in the World, the client should send this to the server:

    {command: 'spawn', value: {x: 10, y: 10}}

where x and y are where you would like it placed in World-coordinates, not local viewport coordinates.

The dx/dy are randomly assigned by the server. The color and dimension of the ball are also randomly assigned by the server.


