class ApplicationController < ActionController::API
    around_action :global_request_logging

    def global_request_logging 
        puts request.get_header("Authorization")
        # http_request_header_keys = request.headers..select{|header_name| header_name.match("^HTTP.*")}
        # http_request_headers = request.headers.select{|header_name, header_value| http_request_header_keys.index(header_name)}
        # logger.info "Received #{request.method.inspect} to #{request.url.inspect} from #{request.remote_ip.inspect}.  Processing with headers #{http_request_headers.inspect} and params #{params.inspect}"
        begin 
        yield 
        ensure 
        logger.info "Responding with #{response.status.inspect} => #{response.body.inspect}"
        end 
    end 
end
