class Proton
  # Module: Cache
  module Cacheable
    def self.enable!
      @enabled = true
    end

    def self.disable!
      @enabled = false
    end

    def self.enabled?()
      !! @enabled
    end
    
    # Enable by default
    enable!

    def self.cache(*args)
      if enabled?
        @cache ||= Hash.new
        args   = args.map { |s| s.to_s }.join('-')
        @cache[args] ||= yield
      else
        yield
      end
    end

    def cache_method(*methods)
      methods.each do |method|
        alias_method :"real_#{method}", method

        class_eval do
          define_method(method) { |*args|
            id = nil
            id ||= self.file  if respond_to?(:file)
            id ||= self.to_s

            Cacheable.cache self.class, method, id, args do
              send :"real_#{method}", *args
            end
          }
        end
      end
    end
  end
end
