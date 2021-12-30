require 'open-uri'
require 'net/http'
require 'httparty'
require 'json'
require 'uri'

# make a call to the express server. 
BASE_URL = 'https://kilimo-shwari-express.herokuapp.com'
# BASE_URL = "http://localhost:3000"

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
        data = {"content" => data}
        puts "REQ DATA :: #{data}"
    
        res = HTTParty.post("#{BASE_URL}/buyPolicy", 
            {
                :body => data.to_json,
                :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
            })
        # puts res.response.code, JSON.parse(res.response.body)["blockHash"]
        return [ res.response.code, JSON.parse(res.response.body)["blockHash"] ]
    end

end