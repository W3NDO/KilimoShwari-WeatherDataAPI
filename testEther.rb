require 'web3/eth'

web3 = Web3::Eth::Rpc.new host: 'explorer.testnet.rsk.co',
                                port: 31,
                                connect_options: {
                                    open_timeout: 20,
                                    read_timeout: 140,
                                    use_ssl: true
                                  }
if web3
    puts web3.eth.contract
else 
    puts false
end

# begin
#     puts "
#         BLOCK NUMBER: #{web3.eth.blocknumber}
#         BALANCE: #{web3.eth.getBalance}
#         "
# rescue
#     puts "ERROR :: #{err}"
# end