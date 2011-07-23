task :test do
  Dir['test/**/*_test.rb'].each { |f| load f }
end

desc "Builds manual."
task :manual do
  Dir.chdir "manual" do
    puts "\nUpdating the manual with inline documentation...\n"
    system "../bin/proton update"
    puts "\nBuilding HTML...\n"
    system "../bin/proton build"
  end

  puts ""
  puts "Now open manual/_output/index.html."
end
task :default => :test
