require 'cuba'
require 'rack'
require 'proton'

# Module: Proton::Server
# The Proton server rack application.

class Proton
  Server = Cuba.dup

  module Server; end

  module Server::PageHelpers
    def not_found
      show_status nil
      res.status = 404
      res.write "<h1>File Not Found</h1><p>The path <code>#{env['PATH_INFO']}</code> was not found." + " "*1024
    end

    def options
      @options ||= Hash.new
    end

    def show_status(page)
      return if options[:quiet]
      path = env['PATH_INFO']
      return  if path == '/favicon.ico'

      status = page ? "\033[0;32m[ OK ]" : "\033[0;31m[404 ]"
      verb = get ? 'GET ' : (post ? 'POST' : '')
      puts "%s\033[0;m %s %s" % [ status, verb, env['PATH_INFO'] ]
      puts "       src: #{page.filepath} (#{page.tilt_engine_name})"  if page && page.tilt?
    end

    def mime_type_for(page)
      type   = page.mime_type
      type ||= Rack::Mime::MIME_TYPES[File.extname(page.file)]
      type
    end

    def server
      Proton::Server
    end
  end

  module Proton::Server
    Ron.send :include, PageHelpers

    define do
      on default do
        begin
          page = Proton::Page[env['PATH_INFO']]  or break not_found

          # Make the clients use If-Modified-Since
          res['Cache-Control'] = 'max-age=86400, public, must-revalidate'

          mtime = [server.options[:last_modified].to_i, File.mtime(page.file).to_i].compact.max
          res['Last-Modified'] = mtime.to_s  if mtime

          # Get the MIME type from Proton, then fallback to Rack
          type = mime_type_for(page)
          res['Content-Type'] = type  if type

          # Okay, we're done
          res.write page.to_html
          show_status page
        rescue => e
          res['Content-Type'] = 'text/html'
          res.write "<h1>#{e.class}: #{e.message}</h1><ul>#{e.backtrace.map{|l|"<li>#{l}</li>"}.join('')}</ul>"
        end
      end
    end
  end
end

module Proton::Server
  # Available options:
  #   :last_modified  -- timestamp for all files
  def self.options
    @options ||= Hash.new 
  end

  # :Host, :Port
  def self.run!(options={})
    self.options.merge options
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
