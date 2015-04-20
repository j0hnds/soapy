#!/usr/bin/env ruby

# This script will submit a request to the MC test server

require 'savon'
require 'libxml'
require 'pry'

class SaxHandler
  include LibXML::XML::SaxParser::Callbacks

  attr_accessor :mds_data, :error, :in_mds_data, :mds_fields, :element_text, :in_service_result, :sr_fields

  def initialize
    @mds_data = []
    @error = nil
    @element_text = nil
    @mds_fields = {}
    @sr_fields = {}
    @in_mds_data = false
    @in_service_result = false
  end

  def on_start_element(element_name, attributes)
    if element_name == 'MDSData'
      self.mds_fields = {}
      self.in_mds_data = true
    elsif element_name == 'ServiceResult'
      self.sr_fields = {}
      self.in_service_result = true
    end
    self.element_text = ''
  end

  def on_characters(text)
    self.element_text << text.strip if in_mds_data || in_service_result
  end

  def on_end_element(element_name)
    if element_name == 'MDSData'
      self.mds_data << self.mds_fields
      self.in_mds_data = false
    elsif element_name == 'ServiceResult'
      self.in_service_result = false
    elsif in_mds_data
      self.mds_fields[element_name] = element_text
    elsif in_service_result
      self.sr_fields[element_name] = element_text
    end
  end

  def on_error(error)
    self.error ||= error.message
  end

end

def wrap_request(req_xml)
  Nokogiri::XML::Builder.new do | xml |
      xml.requestData {
        xml.cdata(req_xml.to_xml)
      }
  end
end

def build_mds_list_request(facility_oid, resident_id)
  Nokogiri::XML::Builder.new do | xml |
      xml.MDIAcheveAPIRequest {
        xml.Version 1.0
        xml.RequestData {
          xml.RequestType "Mds.ListByResident"
          xml.RequestParams {
            xml.FacilityOID facility_oid
            xml.MDSData {
              xml.residentId resident_id
            }
          }
        }
      }
  end
end

# Create a client for the service
client = Savon.client(wsdl: 'http://localhost:3000/matrix_cares/wsdl')

ops = client.operations

puts "Operations: #{ops}"

msg_xml = wrap_request(build_mds_list_request('2.16.124.113611.6432.1.1.999999', 13)).to_xml save_with: Nokogiri::XML::Node::SaveOptions::NO_DECLARATION

response = client.call(:invoke, message: msg_xml)

xml = response.body[:invoke_response][:invoke_response][:return][9..-4]
idx = xml.index('?>')
xml = "<root>#{xml[idx + 2..-1]}</root>"
puts xml

callbacks = SaxHandler.new
parser = LibXML::XML::SaxParser.string(xml)
parser.callbacks = callbacks
parser.parse

if !callbacks.error.nil?
  puts "Error: #{callbacks.error}"
else
  puts callbacks.sr_fields
  puts callbacks.mds_data.inspect
end
