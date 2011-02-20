task :test do
  Dir['test/**/*_test.rb'].each { |f| load f }
end

task :default => :test

task :gembuild do
  require './lib/hyde'
  v = Hyde.version
  system "joe build && git commit -a -m \"Update to version #{v}.\" && git tag v#{v}"
end
