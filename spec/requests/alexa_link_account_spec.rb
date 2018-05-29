require 'rails_helper'

RSpec.describe "link account alexa intent", :type => :request do
  fixtures :users
  
  it "links a user account based on its codeword" do

    u = users(:two)
    
    amazon_user_id = "AMAZONUSER100"
    request_type = "IntentRequest"
    intent_name = "linkaccount"
    slots = {"codeword"=>{"name"=>"codeword", "value"=>u.codeword, "confirmationStatus"=>"NONE"}}
    params = {"version"=>"1.0", "session"=>{"new"=>true, "sessionId"=>"FAKESESSION", "application"=>{"applicationId"=>"FAKESKILLID"}, "user"=>{"userId"=>amazon_user_id}}, "context"=>{"AudioPlayer"=>{"playerActivity"=>"IDLE"}, "Display"=>{}, "System"=>{"application"=>{"applicationId"=>"FAKEALEXAAPPLICATIONID"}, "user"=>{"userId"=>amazon_user_id}, "device"=>{"deviceId"=>"FAKEALEXADEVICEID", "supportedInterfaces"=>{"AudioPlayer"=>{}, "Display"=>{"templateVersion"=>"1.0", "markupVersion"=>"1.0"}}}, "apiEndpoint"=>"https://api.amazonalexa.com", "apiAccessToken"=>"FAKEALEXAAPITOKENs"}}, "request"=>{"type"=>"IntentRequest", "requestId"=>"FAKEALEXAREQUESTID", "timestamp"=>"2018-05-27T01:33:44Z", "locale"=>"en-US", "intent"=>{"name"=>intent_name, "confirmationStatus"=>"NONE", "slots"=>slots}}, "alexa"=>{"version"=>"1.0", "session"=>{"new"=>true, "sessionId"=>"amzn1.echo-api.session.6fbf068c-5312-4b50-9876-a38ccd800dec", "application"=>{"applicationId"=>"amzn1.ask.skill.33a36908-9a18-40d6-9320-ac4e1100b73b"}, "user"=>{"userId"=>"amzn1.ask.account.AH5GC6FFE26J2PMMDX74UARYC5TGVYJ26LME6EDZOFJJENHAEDOLL4FVBUIB35GTF27GBR7IJEKQ2STSOLLS72JZQZAPTWAZHDNEQLO2UCVORPIMBO25QD2LWTR7H2JOFHR52RQI3DLS2BFI4CI23OHSZS6CAFK3IK5DOVQUPQ7DCGYCRQVFHKCWHRC7N2NTMN42YHJR27CEZEA"}}, "context"=>{"AudioPlayer"=>{"playerActivity"=>"IDLE"}, "Display"=>{}, "System"=>{"application"=>{"applicationId"=>"amzn1.ask.skill.33a36908-9a18-40d6-9320-ac4e1100b73b"}, "user"=>{"userId"=>"amzn1.ask.account.AH5GC6FFE26J2PMMDX74UARYC5TGVYJ26LME6EDZOFJJENHAEDOLL4FVBUIB35GTF27GBR7IJEKQ2STSOLLS72JZQZAPTWAZHDNEQLO2UCVORPIMBO25QD2LWTR7H2JOFHR52RQI3DLS2BFI4CI23OHSZS6CAFK3IK5DOVQUPQ7DCGYCRQVFHKCWHRC7N2NTMN42YHJR27CEZEA"}, "device"=>{"deviceId"=>"amzn1.ask.device.AE3QOT4C4CEIQ6KRTYL6J7QTENND27MWS4KRA7IKMUH5JZXEH2XP2G4ZETMKDH2MJ4C5VOEWSWRYLHAVGQZTRPLZ5NIUW5YX5KEKRPV7UDLMR4ABN7DHSQCBILK76DAJD4MGDGLYT2P4EDUP5XQGYWUHXKQA", "supportedInterfaces"=>{"AudioPlayer"=>{}, "Display"=>{"templateVersion"=>"1.0", "markupVersion"=>"1.0"}}}, "apiEndpoint"=>"https://api.amazonalexa.com", "apiAccessToken"=>"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJhdWQiOiJodHRwczovL2FwaS5hbWF6b25hbGV4YS5jb20iLCJpc3MiOiJBbGV4YVNraWxsS2l0Iiwic3ViIjoiYW16bjEuYXNrLnNraWxsLjMzYTM2OTA4LTlhMTgtNDBkNi05MzIwLWFjNGUxMTAwYjczYiIsImV4cCI6MTUyNzM4NTY5NywiaWF0IjoxNTI3MzgyMDk3LCJuYmYiOjE1MjczODIwOTcsInByaXZhdGVDbGFpbXMiOnsiY29uc2VudFRva2VuIjpudWxsLCJkZXZpY2VJZCI6ImFtem4xLmFzay5kZXZpY2UuQUUzUU9UNEM0Q0VJUTZLUlRZTDZKN1FURU5ORDI3TVdTNEtSQTdJS01VSDVKWlhFSDJYUDJHNFpFVE1LREgyTUo0QzVWT0VXU1dSWUxIQVZHUVpUUlBMWjVOSVVXNVlYNUtFS1JQVjdVRExNUjRBQk43REhTUUNCSUxLNzZEQUpENE1HREdMWVQyUDRFRFVQNVhRR1lXVUhYS1FBIiwidXNlcklkIjoiYW16bjEuYXNrLmFjY291bnQuQUg1R0M2RkZFMjZKMlBNTURYNzRVQVJZQzVUR1ZZSjI2TE1FNkVEWk9GSkpFTkhBRURPTEw0RlZCVUlCMzVHVEYyN0dCUjdJSkVLUTJTVFNPTExTNzJKWlFaQVBUV0FaSERORVFMTzJVQ1ZPUlBJTUJPMjVRRDJMV1RSN0gySk9GSFI1MlJRSTNETFMyQkZJNENJMjNPSFNaUzZDQUZLM0lLNURPVlFVUFE3RENHWUNSUVZGSEtDV0hSQzdOMk5UTU40MllISlIyN0NFWkVBIn19.b7VhrJrxTX8Uivn7zd6c0U93NUZxn_risSSJs5tsPLxlD1tTsFw3QYd-2MligHPnkoWRdzsR9EDVdjORdIHZShKC4JzGrNunAacxMyeLIJAIE90VYEFy45QxG12sj9RneaeNciRrvC2e0VTfjWR4g3lhe9mRqrndmulxslZsgby2vlej1WePjLJpQocsTTBzX3vM6R0NgtYTJqjKUso51REjK6sQi17MP0m95I2JWyyevF3t8QvRo0ZH4a_18jk1bo32HG0Ym-6jmiYQ6Zt-KqdPUAEMsJ93t1yjVU2EMjQsuf9WfSlVrlUxNQ_oi3rC51i_RmXLfwOxo6_0x6Khxg"}}, "request"=>{"type"=>request_type, "requestId"=>"amzn1.echo-api.request.73a1b307-442e-444c-b0ba-f4d70815af57", "timestamp"=>"2018-05-27T00:48:17Z", "locale"=>"en-US", "shouldLinkResultBeReturned"=>false}}}
    
    post alexa_path, params: params

    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['response']['outputSpeech']['text']).to include("account has been linked")
    u.reload
    expect(u.amazon_user_identifier).to be_truthy

  end

  it "does not link a user account with a bad codeword" do

    u = users(:two)
    
    amazon_user_id = "AMAZONUSER100"
    request_type = "IntentRequest"
    intent_name = "linkaccount"
    slots = {"codeword"=>{"name"=>"codeword", "value"=>(u.codeword.to_i - 1).to_s, "confirmationStatus"=>"NONE"}}
    params = {"version"=>"1.0", "session"=>{"new"=>true, "sessionId"=>"FAKESESSION", "application"=>{"applicationId"=>"FAKESKILLID"}, "user"=>{"userId"=>amazon_user_id}}, "context"=>{"AudioPlayer"=>{"playerActivity"=>"IDLE"}, "Display"=>{}, "System"=>{"application"=>{"applicationId"=>"FAKEALEXAAPPLICATIONID"}, "user"=>{"userId"=>amazon_user_id}, "device"=>{"deviceId"=>"FAKEALEXADEVICEID", "supportedInterfaces"=>{"AudioPlayer"=>{}, "Display"=>{"templateVersion"=>"1.0", "markupVersion"=>"1.0"}}}, "apiEndpoint"=>"https://api.amazonalexa.com", "apiAccessToken"=>"FAKEALEXAAPITOKENs"}}, "request"=>{"type"=>"IntentRequest", "requestId"=>"FAKEALEXAREQUESTID", "timestamp"=>"2018-05-27T01:33:44Z", "locale"=>"en-US", "intent"=>{"name"=>intent_name, "confirmationStatus"=>"NONE", "slots"=>slots}}, "alexa"=>{"version"=>"1.0", "session"=>{"new"=>true, "sessionId"=>"amzn1.echo-api.session.6fbf068c-5312-4b50-9876-a38ccd800dec", "application"=>{"applicationId"=>"amzn1.ask.skill.33a36908-9a18-40d6-9320-ac4e1100b73b"}, "user"=>{"userId"=>"amzn1.ask.account.AH5GC6FFE26J2PMMDX74UARYC5TGVYJ26LME6EDZOFJJENHAEDOLL4FVBUIB35GTF27GBR7IJEKQ2STSOLLS72JZQZAPTWAZHDNEQLO2UCVORPIMBO25QD2LWTR7H2JOFHR52RQI3DLS2BFI4CI23OHSZS6CAFK3IK5DOVQUPQ7DCGYCRQVFHKCWHRC7N2NTMN42YHJR27CEZEA"}}, "context"=>{"AudioPlayer"=>{"playerActivity"=>"IDLE"}, "Display"=>{}, "System"=>{"application"=>{"applicationId"=>"amzn1.ask.skill.33a36908-9a18-40d6-9320-ac4e1100b73b"}, "user"=>{"userId"=>"amzn1.ask.account.AH5GC6FFE26J2PMMDX74UARYC5TGVYJ26LME6EDZOFJJENHAEDOLL4FVBUIB35GTF27GBR7IJEKQ2STSOLLS72JZQZAPTWAZHDNEQLO2UCVORPIMBO25QD2LWTR7H2JOFHR52RQI3DLS2BFI4CI23OHSZS6CAFK3IK5DOVQUPQ7DCGYCRQVFHKCWHRC7N2NTMN42YHJR27CEZEA"}, "device"=>{"deviceId"=>"amzn1.ask.device.AE3QOT4C4CEIQ6KRTYL6J7QTENND27MWS4KRA7IKMUH5JZXEH2XP2G4ZETMKDH2MJ4C5VOEWSWRYLHAVGQZTRPLZ5NIUW5YX5KEKRPV7UDLMR4ABN7DHSQCBILK76DAJD4MGDGLYT2P4EDUP5XQGYWUHXKQA", "supportedInterfaces"=>{"AudioPlayer"=>{}, "Display"=>{"templateVersion"=>"1.0", "markupVersion"=>"1.0"}}}, "apiEndpoint"=>"https://api.amazonalexa.com", "apiAccessToken"=>"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJhdWQiOiJodHRwczovL2FwaS5hbWF6b25hbGV4YS5jb20iLCJpc3MiOiJBbGV4YVNraWxsS2l0Iiwic3ViIjoiYW16bjEuYXNrLnNraWxsLjMzYTM2OTA4LTlhMTgtNDBkNi05MzIwLWFjNGUxMTAwYjczYiIsImV4cCI6MTUyNzM4NTY5NywiaWF0IjoxNTI3MzgyMDk3LCJuYmYiOjE1MjczODIwOTcsInByaXZhdGVDbGFpbXMiOnsiY29uc2VudFRva2VuIjpudWxsLCJkZXZpY2VJZCI6ImFtem4xLmFzay5kZXZpY2UuQUUzUU9UNEM0Q0VJUTZLUlRZTDZKN1FURU5ORDI3TVdTNEtSQTdJS01VSDVKWlhFSDJYUDJHNFpFVE1LREgyTUo0QzVWT0VXU1dSWUxIQVZHUVpUUlBMWjVOSVVXNVlYNUtFS1JQVjdVRExNUjRBQk43REhTUUNCSUxLNzZEQUpENE1HREdMWVQyUDRFRFVQNVhRR1lXVUhYS1FBIiwidXNlcklkIjoiYW16bjEuYXNrLmFjY291bnQuQUg1R0M2RkZFMjZKMlBNTURYNzRVQVJZQzVUR1ZZSjI2TE1FNkVEWk9GSkpFTkhBRURPTEw0RlZCVUlCMzVHVEYyN0dCUjdJSkVLUTJTVFNPTExTNzJKWlFaQVBUV0FaSERORVFMTzJVQ1ZPUlBJTUJPMjVRRDJMV1RSN0gySk9GSFI1MlJRSTNETFMyQkZJNENJMjNPSFNaUzZDQUZLM0lLNURPVlFVUFE3RENHWUNSUVZGSEtDV0hSQzdOMk5UTU40MllISlIyN0NFWkVBIn19.b7VhrJrxTX8Uivn7zd6c0U93NUZxn_risSSJs5tsPLxlD1tTsFw3QYd-2MligHPnkoWRdzsR9EDVdjORdIHZShKC4JzGrNunAacxMyeLIJAIE90VYEFy45QxG12sj9RneaeNciRrvC2e0VTfjWR4g3lhe9mRqrndmulxslZsgby2vlej1WePjLJpQocsTTBzX3vM6R0NgtYTJqjKUso51REjK6sQi17MP0m95I2JWyyevF3t8QvRo0ZH4a_18jk1bo32HG0Ym-6jmiYQ6Zt-KqdPUAEMsJ93t1yjVU2EMjQsuf9WfSlVrlUxNQ_oi3rC51i_RmXLfwOxo6_0x6Khxg"}}, "request"=>{"type"=>request_type, "requestId"=>"amzn1.echo-api.request.73a1b307-442e-444c-b0ba-f4d70815af57", "timestamp"=>"2018-05-27T00:48:17Z", "locale"=>"en-US", "shouldLinkResultBeReturned"=>false}}}
    
    post alexa_path, params: params

    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['response']['outputSpeech']['text']).to include("Unable to connect your account")
    u.reload
    expect(u.amazon_user_identifier).to be_nil

  end

  it "does not link a user account that has already been linked, even if a recycled codeword" do

    u = users(:one)
    ub = users(:two)
    ub.update_attributes(:codeword => u.codeword)
    
    amazon_user_id = u.amazon_user_identifier
    request_type = "IntentRequest"
    intent_name = "linkaccount"
    slots = {"codeword"=>{"name"=>"codeword", "value"=>ub.codeword, "confirmationStatus"=>"NONE"}}
    params = {"version"=>"1.0", "session"=>{"new"=>true, "sessionId"=>"FAKESESSION", "application"=>{"applicationId"=>"FAKESKILLID"}, "user"=>{"userId"=>amazon_user_id}}, "context"=>{"AudioPlayer"=>{"playerActivity"=>"IDLE"}, "Display"=>{}, "System"=>{"application"=>{"applicationId"=>"FAKEALEXAAPPLICATIONID"}, "user"=>{"userId"=>amazon_user_id}, "device"=>{"deviceId"=>"FAKEALEXADEVICEID", "supportedInterfaces"=>{"AudioPlayer"=>{}, "Display"=>{"templateVersion"=>"1.0", "markupVersion"=>"1.0"}}}, "apiEndpoint"=>"https://api.amazonalexa.com", "apiAccessToken"=>"FAKEALEXAAPITOKENs"}}, "request"=>{"type"=>"IntentRequest", "requestId"=>"FAKEALEXAREQUESTID", "timestamp"=>"2018-05-27T01:33:44Z", "locale"=>"en-US", "intent"=>{"name"=>intent_name, "confirmationStatus"=>"NONE", "slots"=>slots}}, "alexa"=>{"version"=>"1.0", "session"=>{"new"=>true, "sessionId"=>"amzn1.echo-api.session.6fbf068c-5312-4b50-9876-a38ccd800dec", "application"=>{"applicationId"=>"amzn1.ask.skill.33a36908-9a18-40d6-9320-ac4e1100b73b"}, "user"=>{"userId"=>"amzn1.ask.account.AH5GC6FFE26J2PMMDX74UARYC5TGVYJ26LME6EDZOFJJENHAEDOLL4FVBUIB35GTF27GBR7IJEKQ2STSOLLS72JZQZAPTWAZHDNEQLO2UCVORPIMBO25QD2LWTR7H2JOFHR52RQI3DLS2BFI4CI23OHSZS6CAFK3IK5DOVQUPQ7DCGYCRQVFHKCWHRC7N2NTMN42YHJR27CEZEA"}}, "context"=>{"AudioPlayer"=>{"playerActivity"=>"IDLE"}, "Display"=>{}, "System"=>{"application"=>{"applicationId"=>"amzn1.ask.skill.33a36908-9a18-40d6-9320-ac4e1100b73b"}, "user"=>{"userId"=>"amzn1.ask.account.AH5GC6FFE26J2PMMDX74UARYC5TGVYJ26LME6EDZOFJJENHAEDOLL4FVBUIB35GTF27GBR7IJEKQ2STSOLLS72JZQZAPTWAZHDNEQLO2UCVORPIMBO25QD2LWTR7H2JOFHR52RQI3DLS2BFI4CI23OHSZS6CAFK3IK5DOVQUPQ7DCGYCRQVFHKCWHRC7N2NTMN42YHJR27CEZEA"}, "device"=>{"deviceId"=>"amzn1.ask.device.AE3QOT4C4CEIQ6KRTYL6J7QTENND27MWS4KRA7IKMUH5JZXEH2XP2G4ZETMKDH2MJ4C5VOEWSWRYLHAVGQZTRPLZ5NIUW5YX5KEKRPV7UDLMR4ABN7DHSQCBILK76DAJD4MGDGLYT2P4EDUP5XQGYWUHXKQA", "supportedInterfaces"=>{"AudioPlayer"=>{}, "Display"=>{"templateVersion"=>"1.0", "markupVersion"=>"1.0"}}}, "apiEndpoint"=>"https://api.amazonalexa.com", "apiAccessToken"=>"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJhdWQiOiJodHRwczovL2FwaS5hbWF6b25hbGV4YS5jb20iLCJpc3MiOiJBbGV4YVNraWxsS2l0Iiwic3ViIjoiYW16bjEuYXNrLnNraWxsLjMzYTM2OTA4LTlhMTgtNDBkNi05MzIwLWFjNGUxMTAwYjczYiIsImV4cCI6MTUyNzM4NTY5NywiaWF0IjoxNTI3MzgyMDk3LCJuYmYiOjE1MjczODIwOTcsInByaXZhdGVDbGFpbXMiOnsiY29uc2VudFRva2VuIjpudWxsLCJkZXZpY2VJZCI6ImFtem4xLmFzay5kZXZpY2UuQUUzUU9UNEM0Q0VJUTZLUlRZTDZKN1FURU5ORDI3TVdTNEtSQTdJS01VSDVKWlhFSDJYUDJHNFpFVE1LREgyTUo0QzVWT0VXU1dSWUxIQVZHUVpUUlBMWjVOSVVXNVlYNUtFS1JQVjdVRExNUjRBQk43REhTUUNCSUxLNzZEQUpENE1HREdMWVQyUDRFRFVQNVhRR1lXVUhYS1FBIiwidXNlcklkIjoiYW16bjEuYXNrLmFjY291bnQuQUg1R0M2RkZFMjZKMlBNTURYNzRVQVJZQzVUR1ZZSjI2TE1FNkVEWk9GSkpFTkhBRURPTEw0RlZCVUlCMzVHVEYyN0dCUjdJSkVLUTJTVFNPTExTNzJKWlFaQVBUV0FaSERORVFMTzJVQ1ZPUlBJTUJPMjVRRDJMV1RSN0gySk9GSFI1MlJRSTNETFMyQkZJNENJMjNPSFNaUzZDQUZLM0lLNURPVlFVUFE3RENHWUNSUVZGSEtDV0hSQzdOMk5UTU40MllISlIyN0NFWkVBIn19.b7VhrJrxTX8Uivn7zd6c0U93NUZxn_risSSJs5tsPLxlD1tTsFw3QYd-2MligHPnkoWRdzsR9EDVdjORdIHZShKC4JzGrNunAacxMyeLIJAIE90VYEFy45QxG12sj9RneaeNciRrvC2e0VTfjWR4g3lhe9mRqrndmulxslZsgby2vlej1WePjLJpQocsTTBzX3vM6R0NgtYTJqjKUso51REjK6sQi17MP0m95I2JWyyevF3t8QvRo0ZH4a_18jk1bo32HG0Ym-6jmiYQ6Zt-KqdPUAEMsJ93t1yjVU2EMjQsuf9WfSlVrlUxNQ_oi3rC51i_RmXLfwOxo6_0x6Khxg"}}, "request"=>{"type"=>request_type, "requestId"=>"amzn1.echo-api.request.73a1b307-442e-444c-b0ba-f4d70815af57", "timestamp"=>"2018-05-27T00:48:17Z", "locale"=>"en-US", "shouldLinkResultBeReturned"=>false}}}
    
    post alexa_path, params: params

    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['response']['outputSpeech']['text']).to include("Unable to connect your account")
    u.reload
    expect(u.amazon_user_identifier).to be u.amazon_user_identifier

  end
end
