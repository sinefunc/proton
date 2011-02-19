require 'cuba'
require 'rack'
require 'hyde'

class Hyde
  Server = Cuba.dup

  module Server::PageHelpers
    def not_found
      show_status nil
      res.status = 404
      res.write "404"
    end

    def show_status(page)
      path = env['PATH_INFO']
      return  if path == '/favicon.ico'

      status = page ? "\033[0;32m[ OK ]" : "\033[0;31m[404 ]"
      verb = get ? 'GET ' : (post ? 'POST' : '')
      puts "%s\033[0;m %s %s" % [ status, verb, env['PATH_INFO'] ]
      puts "       Source: #{page.file.sub(page.project.path(:site), '')} (#{page.tilt_engine_name})"  if page.tilt?
    end
  end

  module Hyde::Server
    Ron.send :include, PageHelpers

    define do
      on default do
        page = Hyde::Page[env['PATH_INFO']]  or break not_found
        res.write page.to_html
        show_status page
      end
    end
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
