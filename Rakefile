task :test do
  Dir['test/**/*_test.rb'].each { |f| load f }
end

namespace :doc do
  desc "Builds the docs in doc/."
  task :update do
    # gem install proscribe (~> 0.0.2)
    system "proscribe build"
  end

  desc "Updates the online manual."
  task :deploy => :update do
    # http://github.com/rstacruz/git-update-ghpages
    system "git update-ghpages sinefunc/proton -i doc --prefix manual"
  end
end

task :default => :test
