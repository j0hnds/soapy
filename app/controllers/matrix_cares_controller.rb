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
     <![CDATA[BHS|^~\&
MSH|^~\&|AHT^Matrix|999999^MDI Achieve Care Center|||20140624123109||ADT^A03|2165|D|2.3.1||||||ASCII
EVN|A03|||03||20140623154500
PID||11|04312^^^^MR~11^^^^FI~238638999^^^^SS||Aaron^Harold|Johnson|19300101|M||WHITE^White, not of Hispanic origin|10 Main Street^^Rockford^IL^60010^USA^C||||^English|M^Married|LUT^Lutheran||238638999     
PV1|||East^304^A||||^Smith^James^^MD^Dr.^^^&A65465||||||||||^Smith^James^^MD^     Dr.^^^&A65465|||None||||||||||||||||01|^20140623154500|||||||20140215173200|2     
DG1|1|ICD9|436^Disease, acute cerbvas, ill-defined -     
CVA||20040121000000|A|||||||||1     
DG1|2|ICD9|496^Obstruction, chronic airway NEC||20040121000000|W|||||||||2     
DG1|3|ICD9|401.9^Hypertension, essential NOS||20040121000000|W|||||||||2     
DG1|4|ICD9|252.0^Hyperparathyroidism||20040124000000|W|||||||||2     
DG1|5|ICD9|263.1^Malnutrition, mild degree||20040121000000|W|||||||||210 MatrixCare HL7 ADT Export API Technical Guide     
DG1|6|ICD9|496^Obstruction, chronic airway NEC||20060713000000|W|||||||||2     
DG1|7|ICD9|428.0^Failure, congestive heart NOS||20060712000000|W|||||||||2     
DG1|8|ICD9|599.0^Infection, urinary tract NOS||20060701000000|W|||||||||2     
DG1|9|ICD9|345.00^Epil, gnrlzd ncnvl w/o intrctepil||20040121000000|W|||||||||2     
MSH|^~\&|AHT^Matrix|999999^MDI Achieve Care Center|||20140624123109||ADT^A22|2166|D|2.3.1||||||ASCII     
EVN|A22|||03||20140620154200     
PID||11|04312^^^^MR~11^^^^FI~238638999^^^^SS||Aaron^Harold|Johnson|19300101|M||WHITE^White, not of Hispanic origin|10 Main Street^^Rockford^IL^60010^USA^C||||^English|M^Married|LUT^Lutheran||238638999     
PV1|||East^304^A|3|||^Smith^James^^MD^Dr.^^^&A65465|||||||2|||^Smith^James^^MD^Dr.^^^&A65465|||None||||||||||||||||||||||||20140215173200     
MSH|^~\&|AHT^Matrix|999999^MDI Achieve Care Center|||20140624123109||ADT^A04|2168|D|2.3.1||||||ASCII     
EVN|A04|||03||20140623115900     
PID||12947|3432^^^^MR~12947^^^^FI~159652347^^^^SS||Harris^Gilda||19130515|F||WHITE^White, not of Hispanic origin|15263 Dell Way^^Peoria^IL^58952^USA^C||||^English|M^Married|CHR^Christian||159652347||||     
PV1||||3||||||||||2||||||||||||||||||||||||||||||20140623115900]]>
    EOF
  end

end
