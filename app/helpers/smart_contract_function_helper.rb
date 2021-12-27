require 'open-uri'
require 'net/http'
require 'httparty'

# make a call to the express server. 
# BASE_URL = 'https://kilimo-shwari-express.herokuapp.com'
BASE_URL = "http://localhost:3000"

# Express endpoints
    # "/" => GET, return all policies
    # '/policy/:id' => GET, return specific ID
    # '/buyPolicy' => POST, buy a new policy

module SmartContractFunctionHelper
    def getAllPolicies()
        res = HTTParty.get(BASE_URL)
        return res
    end

    def getPolicy(id)
        res = HTTParty.get(BASE_URL + '/policy/'+id)

        return  res_code
    end

    def buyPolicy(data)
        #needs to be async
        # puts data
        res = HTTParty.post(BASE_URL + '/buyPolicy', {:body => {"content" => data}}) #find post syntax
        res_code = res
        puts "RES::::: #{res_code}"
        
        return res
    end

end