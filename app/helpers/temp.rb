require 'open-uri'
require 'net/http'
require 'httparty'
require 'json'
require 'uri'

# make a call to the express server. 
# BASE_URL = 'https://kilimo-shwari-express.herokuapp.com'
BASE_URL = "http://localhost:3000"

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

buyPolicy([5,6,"Hybrid Series 6", 1640574886, 1635304486])