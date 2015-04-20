class MatrixCaresController < ApplicationController
  soap_service namespace: "http://external.api.integration.mdiachieve.com/", wsdl_style: :document, camelize_wsdl: :lower, snakecase_input: false

  soap_action "invoke",
    args: { invoke: { requestData: :string } },
    return: { invokeResponse: { return: :string } }

  def invoke
    request.body.rewind
    inp = request.body.read
    puts "Here's what we got: #{inp}"
    puts "Params: #{params}"
    # inp = 'out'
    render soap: { invokeResponse: { return: sample_response } }
    # raise SOAPError, "Something is broke"
  end

  def sample_response
    resp = <<-EOF
    <![CDATA[<?xml version="1.0" encoding="UTF-8"?><MDSData>
    <residentId>13</residentId>
    <mdsID>228896</mdsID>
    <a0310A>01</a0310A>
    <a0310B>01</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2014-10-02T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>228426</mdsID>
    <a0310A>03</a0310A>
    <a0310B>99</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2014-10-01T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>228288</mdsID>
    <a0310A>01</a0310A>
    <a0310B>01</a0310B>
    <a0310C>1</a0310C>
    <a0310F>99</a0310F>
    <a2300>2014-06-25T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>227975</mdsID>
    <a0310A>03</a0310A>
    <a0310B>99</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2014-04-21T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>227102</mdsID>
    <a0310A>01</a0310A>
    <a0310B>01</a0310B>
    <a0310C>0</a0310C>
    <a0310F>10</a0310F>
    <a2300>2014-01-09T00:00:00.000-06:00</a2300>
    <mdsAssessmentStatusCode>PROD_REJECTED</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>225791</mdsID>
    <a0310A>99</a0310A>
    <a0310B>07</a0310B>
    <a0310C>1</a0310C>
    <a0310F>99</a0310F>
    <a2300>2013-10-01T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>226145</mdsID>
    <a0310A>03</a0310A>
    <a0310B>99</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2013-09-30T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>225902</mdsID>
    <a0310A>04</a0310A>
    <a0310B>99</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2013-03-28T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>16597</mdsID>
    <a0310A>04</a0310A>
    <a0310B>99</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2010-10-16T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData><MDSData>
    <residentId>13</residentId>
    <mdsID>228768</mdsID>
    <a0310A>03</a0310A>
    <a0310B>99</a0310B>
    <a0310C>0</a0310C>
    <a0310F>99</a0310F>
    <a2300>2010-10-01T00:00:00.000-05:00</a2300>
    <mdsAssessmentStatusCode>IN_PROCESS</mdsAssessmentStatusCode>
    </MDSData>
     <ServiceResult>
      <TransactionId>0</TransactionId>
      <MessageTxt></MessageTxt>
       </ServiceResult>]]>
    EOF
  end

end
