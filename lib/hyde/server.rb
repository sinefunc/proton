require 'cuba'
require 'rack'
require 'hyde'

Hyde::Server = Cuba.dup

Hyde::Server.define do
  on default do
    res.write path
  end
end

module Hyde::Server
  # :Host, :Port
  def self.run!(options={})
    handler = rack_handler  or return false
    handler.run self, options
  end

  def self.rack_handler
    %w(thin mongrel webrick).each do |svr|
      begin
        return Rack::Handler.get(svr)
      rescue LoadError
      rescue NameError
      end
    end
  end
end
