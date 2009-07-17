class Rack::Builder
  def proxy_pass target, source, &block
    run Rack::ProxyPass.new(target, source, &block)
  end
end
