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
    render soap: { invokeResponse: { return: error_response } }
    # raise SOAPError, "Something is broke"
  end

  private

  def error_response
    resp = <<-EOF
      &lt;?xml version="1.0"?&gt;
      &lt;MDIAchieveAPIRequest&gt;
      &lt;Version&gt;1.0&lt;/Version&gt;
      &lt;RequestData&gt;
      &lt;RequestType&gt;ADT.HL7.Export&lt;/RequestType&gt;
      &lt;RequestParams&gt;
      &lt;FacilityOID&gt;13611.6432.1.1.999999&lt;/FacilityOID&gt;
      &lt;StartDate&gt;2015-10-01T07:00:00&lt;/StartDate&gt;
      &lt;EndDate&gt;2015-10-01T14:05:59&lt;/EndDate&gt;
      &lt;/RequestParams&gt;
      &lt;/RequestData&gt;
      &lt;/MDIAchieveAPIRequest&gt;
      &lt;ServiceResult&gt;
      &lt;TransactionId&gt;401&lt;/TransactionId&gt;
      &lt;MessageTxt&gt;Unauthorized - MatrixCare was unable to authenticate your request.  Please contact MatrixCare support.&lt;/MessageTxt&gt;
      &lt;/ServiceResult&gt;
    EOF
    resp
  end

  def success_response
    resp = <<-EOF
      BHS|^~\&amp;
      MSH|^~\&amp;|AHT^Matrix|999999^MDI Achieve Care Center|||20151022095708||ADT^A08|90129|P|2.3.1||||||ASCII
      EVN|A08|||03||20151022140559
      PID||14|3743^^^^MR~14^^^^FI~211111182^^^^SS||Adams^Susan^M|Smith|19250515|F|^Susie|WHITE^White, not of Hispanic origin|1310 Oak St^^Cleveland^OH^45606^USA^C||||^English|M^Married|C^Catholic||211111182|||||||||||N
      NK1|1|Adams^John|^Son|123 Miller Ave^^Chicago^IL^^USA^M|^^^^^952^5555551||^Emergency Contact,Family Member Responsible,Primary Financial Contact,Receives AR Statement
      NK1|2|Smith^Catherine|^Friend|123 Main St^^Chicago^IL^60605^USA^M|^^^^^654^7897894
      PV1|||Unit 02^1^1||||^Benson^Harvey^^MD^Dr.^^^&amp;1345678323||||||||||^Benson^Harvey^^MD^Dr.^^^&amp;1345678323|||Intermediate||||||||||||||||||||||||20040301105600
      AL1|1|DA|491^Sulfonamides (Sulfa)^FDDC|||20040301
      DG1|1|ICD9|486^Pneumonia, organism NOS||20040301000000|A|||||||||1
      DG1|2|ICD9|728.85^Spasm, muscle||20130712000000|W|||||||||2
      DG1|3|ICD9|599.0^Infection, urinary tract NOS||20040301000000|W|||||||||2
      DG1|4|ICD9|530.81^Reflux, esophageal||20040301000000|W|||||||||2
      DG1|5|ICD9|250.00^DM, uncomplicated, type II||20040301000000|W|||||||||2
      DG1|6|ICD9|428.0^Failure, congestive heart NOS||20040301000000|W|||||||||2
      IN1|1|^100001||Medicare A||||||||20040301|||Census|||||Y|||||||Y|||||||||444747475A
      IN1|2|^100001||Medicare B||||||||20040609|||Census|||||Y|||||||Y|||||||||3326
      IN1|3|^100000001||Medicaid^^^1||||||||20040609|||Census|||||Y|||||||Y|||||||||6765434663
      IN1|4|||Private||||||||20040301|||Census|||||Y|||||||Y
      IN1|5|||Patient Liability||||||||20040601|||Census|||||N|||||||Y
      MSH|^~\&amp;|AHT^Matrix|999999^MDI Achieve Care Center|||20151022095708||ADT^A08|90130|P|2.3.1||||||ASCII
      EVN|A08|||03||20151022140559
      PID||40|4730^^^^MR~40^^^^FI~111111119^^^^SS||Ziebrath^Mark||19290523|M||WHITE^White, not of Hispanic origin|557 West 7th^^Chicago^IL^60605^USA^C||||^English|M^Married|C^Catholic||111111119|||||||||||N
      PV1|||East^102^B||||^Benson^Harvey^^MD^Dr.^^^&amp;1345678323||||||||||^Benson^Harvey^^MD^Dr.^^^&amp;1345678323|||Basic||||||||||||||||||||||||20040318144100
      AL1|1|DA|491^Sulfonamides (Sulfa)^FDDC|||20040318
      DG1|1|ICD9|428.0^Failure, congestive heart NOS||20040318000000|A|||||||||1
      DG1|2|ICD9|250.60^DM w/neuro mnfst, type II||20040318000000|W|||||||||2
      DG1|3|ICD9|585^Renal failure, chronic||20040318000000|W|||||||||2
      DG1|4|ICD9|715.90^Osteoarthrosis NOS, unspc site||20040318000000|W|||||||||2
      DG1|5|ICD9|401.9^Hypertension, essential NOS||20040318000000|W|||||||||2
      DG1|6|ICD9|414.00^Athrsclr, coronary, vessel type NOS||20040318000000|W|||||||||2
      DG1|7|ICD9|300.4^Depression, neurotic||20040318000000|W|||||||||2
      DG1|8|ICD9|294.8^Dementia, mild||20040318000000|W|||||||||2
      DG1|9|ICD9|280.9^Anemia, iron deficiency NOS||20040318000000|W|||||||||2
      DG1|10|ICD9|272.4^Hyperlipidemia NEC/NOS||20040318000000|W|||||||||2
      DG1|11|ICD9|V58.43^Aftrcr following inj/traum surgery||20040318000000|W|||||||||2
      DG1|12|ICD9|599.0^Infection, urinary tract NOS||20060802000000|W|||||||||2
      DG1|13|ICD9|438.20^Hemiplg afctg unspc side LE cerbvas||20060801000000|W|||||||||2
      DG1|14|ICD9|530.81^Reflux, esophageal||20040318000000|W|||||||||2
      DG1|15|ICD9|244.9^Hypothyroidism NOS||20021222000000|W|||||||||2
      IN1|1|^100001||Medicare A||||||||20060805|||Census|||||Y|||||||Y|||||||||111111119A
      IN1|2|||Private^^^1||||||||20040318|||Census|||||Y|||||||Y
      MSH|^~\&amp;|AHT^Matrix|999999^MDI Achieve Care Center|||20151022095708||ADT^A08|90131|P|2.3.1||||||ASCII
      EVN|A08|||03||20151022140559
      PID||52|4583^^^^MR~52^^^^FI~111111117^^^^SS||St Claire^Melvin||19230721|M|^Mel|WHITE^White, not of Hispanic origin|63698 West 3rd^^Chicago^IL^69996^USA^C||||^English|W^Widowed|ME^Methodist||111111117|||||||||||N
      PV1|||East^121^A||||^James^Robert^K^MD^Dr.^^^&amp;1032467568||||||||||^James^Robert^K^MD^Dr.^^^&amp;1032467568|||Skilled||||||||||||||||||||||||20090701122000
      DG1|1|ICD9|436^Disease, acute cerbvas, ill-defined - CVA||20040211000000|W|||||||||1
      DG1|2|ICD9|782.3^Symptom, edema||20040211000000|W|||||||||2
      DG1|3|ICD9|600.00^Hyprtrphy prst bng w/o urinary obst||20040211000000|W|||||||||2
      DG1|4|ICD9|401.9^Hypertension, essential NOS||20040211000000|W|||||||||2
      IN1|1|^100001||Medicare A^^^1||||||||20090701|||Census|||||Y|||||||Y|||||||||111111117A
      IN1|2|||Unicare Part A||||||||20060417|||Census|||||Y|||||||Y|||||||||111111117
      IN1|3|^100001||Medicare B||||||||20040211|||Census|||||Y|||||||Y|||||||||111111117A
      IN1|4|^464671||Co-Insurance||||||||20040211|||Census|||||Y||1|||||Y|||||||||6467717
      IN1|5|^845654||Blue Cross Levels||||||||20040211|||Census|||||Y||2|||||Y|||||||||78946467
      IN1|6|^100000001||Medicaid||||||||20070801|||Census|||||Y|||||||Y
      IN1|7|||Patient Liability||||||||20070801|||Census|||||N|||||||Y
      IN1|8|||Private||||||||20040211|||Census|||||Y|||||||Y
      MSH|^~\&amp;|AHT^Matrix|999999^MDI Achieve Care Center|||20151022095708||ADT^A08|90132|P|2.3.1||||||ASCII
      EVN|A08|||03||20151022140559
      PID||203|3259^^^^MR~203^^^^FI~567322667^^^^SS||Bubboltz^Pauline||19350526|F||WHITE^White, not of Hispanic origin|^^^IL^^USA^C||||^English|M^Married|SCI^Scientology||567322667|||||||||||N
      NK1|1|Bubboltz^Paula|^Daughter|57 Dana Avenue^^Cleveland^OH^68213^USA^M|^^^^^236^4581356||^Emergency Contact,Responsible Party,Durable POA - Financial,Durable POA - Health care,Primary Financial Contact,Receives AR Statement
      PV1|||Unit 07^1^2||||^Flint^Christopher^^MD^Dr.^^^&amp;1836357312||||||||||^Flint^Christopher^^MD^Dr.^^^&amp;1836357312|||Basic||||||||||||||||||||||||20090706124100
      DG1|1|ICD9|295.01^Schizophrenia, simple, subchronic||20080607000000|W|||||||||2
      DG1|2|ICD9|250.10^DM w/ketoacidosis, type II||20080607000000|W|||||||||2
      GT1|1|677|Bubboltz^Paula||57 Dana Avenue^^Cleveland^OH^68213^USA^M|||||||||||||||||N
      IN1|1|||Unicare Part A||||||||20080616|||Census|||||Y|||||||Y|||||||||567322667
      IN1|2|||UCare Levels||||||||20080607|||Census|||||Y||1|||||Y|||||||||567322667
      IN1|3|||Private^^^1||||||||20080607|||Census|||||Y|||||||Y
      BTS|
    EOF
    resp
  end

end
