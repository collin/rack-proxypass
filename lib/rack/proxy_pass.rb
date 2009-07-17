class Rack::ProxyPass
  def initialize src, target, &block
    @src, @target, @block = src, target, (block || lambda {|echo|echo})
  end
  
  def call env
    request = Rack::Request.new(env)
    response = request.forward_to(request.fullpath.sub(@src, @target), &@block)
  end
end
