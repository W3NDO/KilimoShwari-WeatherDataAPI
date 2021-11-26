require 'ethereum.rb'
require 'json'
client = Ethereum::HttpClient.new('https://ropsten.infura.io/v3/bfd2419d8f3242d494de2fc399e01c34')
file = File.read('./abi.json')
abi = [
    JSON.parse(file)
]
address = '0xC0e35F28Bd33bE2F28418d07A1Ce8DFd766F431F'

contract = Ethereum::Contract.create(name: "MaizeInsurance", address: address)
contract.call.get_policy()