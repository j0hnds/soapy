class OrigamiRisksController < ApplicationController
  soap_service namespace: "http://tempuri.org/", wsdl_style: :document, camelize_wsdl: :upper, snakecase_input: false

  soap_action "CreateSessionToken",
    args: { create_session_token: { account: :string, clientName: :string, userName: :string, password: :string } },
    return: { create_session_token_response: { create_session_token_result: :string } }

  def CreateSessionToken
  	puts params.inspect
  	request.body.rewind
  	puts request.body.read
    render soap: { create_session_token_response: { create_session_token_result: 'XXXXXXX' } }
  end
end