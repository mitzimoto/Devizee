#!/usr/local/bin/ruby

require 'socket'

hostname = 'localhost'
port = 7070

sock = TCPSocket.open hostname, port

unless sock 
    print "Failed to connect to socket"
    exit 1
end

sock.print("71359563\n")

while line = sock.gets
    line.chomp!
    puts "{\"status\":\"#{line}\"}"
end

sock.close
