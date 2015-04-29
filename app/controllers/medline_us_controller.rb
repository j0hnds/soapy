class MedlineUsController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :validate_security_token

  def updateFacility
    request.body.rewind

    request_body = request.body.read

    response_string = ''
    successful = true
    status = 200
    errors = []

    begin
      request_hash = Hash.from_xml(request_body)
      # Make sure the request is valid
      raise "Root element must be: 'care_area_update_request'" unless request_hash.has_key?('care_area_update_request')
      raise "'Must provide a facility identifier" unless request_hash['care_area_update_request'].has_key?('facility_identifier') && request_hash['care_area_update_request']['facility_identifier'].present?
      raise "'Must provide a care_areas element'" unless request_hash['care_area_update_request'].has_key?('care_areas')

      facility_identifier = request_hash['care_area_update_request']['facility_identifier'].to_i
      if request_hash['care_area_update_request']['care_areas'].present?
        ca_ids = request_hash['care_area_update_request']['care_areas']['id']
      else
        ca_ids = []
      end
      if facility_identifier > 100
        errors << "Facility #{facility_identifier} is not registered with MedlineU"
        successful = false
      end
      if ca_ids.present?
        if ca_ids.is_a?(Array)
          ca_ids.map { | sid | sid.to_i }.each do | id |
            if id > 100
              errors << "Care area #{id} is not registered with MedlineU"
              successful = false
            end
          end
        else
          id = ca_ids.to_i
          if id > 100 
            errors << "Care area #{id} is not registered with MedlineU"
            successful = false
          end
        end
      end
    rescue REXML::ParseException => ex
      errors << ex.message
      status = 500
      successful = false
    rescue Exception => ex
      errors << ex.message
      status = 500
      successful = false
    end

    markup = Builder::XmlMarkup.new(target: response_string, indent: 2)
    markup.instruct!(:xml, :version => '1.0')
    markup.care_area_update_response do | caur |
      caur.response(successful ? 'success' : 'error')
      if !successful && errors.present?
        caur.errors(type: 'array') do | xerrors |
          errors.each do | error |
            xerrors.error(error)
          end
        end
      end
    end

    render text: response_string, status: status
  end

  private

  def validate_security_token
    token = request.headers['HTTP_SECURITY_TOKEN']
    if token.blank? || token != 'Test1234'
      render text: "Invalid security token", status: 401
    end
  end

end
