require 'web3/eth'
# require './infura_key.rb'
require 'json'
file = File.read('./abi.json')
abi = [
    JSON.parse(file)
]
address = '0xC0e35F28Bd33bE2F28418d07A1Ce8DFd766F431F'

web3 = Web3::Eth::Rpc.new host: 'https://ropsten.infura.io/v3/bfd2419d8f3242d494de2fc399e01c34',
                                port: 443,
                                connect_options: {
                                    open_timeout: 20,
                                    read_timeout: 140,
                                    use_ssl: true,
                                  }
if web3
    web3.eth.contract(address=address)
    begin 
        web3.eth.contract(address=address, abi=abi)
    rescue
        puts "LOOOOL"
    end
else 
    puts false
end

