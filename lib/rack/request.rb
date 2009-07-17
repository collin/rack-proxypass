class Rack::Request
  def forward_to target, &block
    curl = Curl::Easy.new(target)
    #curl.headers.merge headers
    case
      when get?
        curl.http_get
      when post?
        curl.http_post body
      when put?
        curl.http_put body
      when delete?
        curl.http_delete
      else
        raise "Unimplemented HTTP methof for Rack::Request#forward"
    end
    
    headers = {}
    
    curl.header_str.split("\r\n")[1..-1].each do |item| 
      k,v = item.split(": ")
      headers[k] = v
    end
      
    headers.delete "Vary"
    headers.delete "Transfer-Encoding"
    headers.delete "Date"
    
    [curl.response_code, headers, yield(curl.body_str)]
  end
end

