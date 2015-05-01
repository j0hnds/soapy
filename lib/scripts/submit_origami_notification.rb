#!/usr/bin/env ruby

# This script will submit a request to the Origami test server

require 'savon'
require 'libxml'
require 'pry'

# Create a client for the service
#client = Savon.client(wsdl: 'https://live.origamirisk.com/Origami.WebServices/ServiceLibrary.svc?wsdl')
client = Savon::Client.new(wsdl: 'http://localhost:3000/origami_risks/wsdl')



ops = client.operations

puts "Operations: #{ops}"

token = client.call(:create_session_token, message: { :account => "Prestige", :clientName => "John Doe",
                     :userName => "abaqis", :password => "origami" })

puts token.to_hash

