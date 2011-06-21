desc "Update"
task :build do
  require 'fileutils'

  # Reset

  # Build our files
  system "proton build"

  # Build the manual over there
  app_path = ENV['PROTON_PATH'] || '../app'
  Dir.chdir("#{app_path}/manual") do
    system "proton update"
    system "proton build"
  end

  # Copy it here (reset first)
  FileUtils.rm_rf "./_public/manual"
  FileUtils.cp_r "#{app_path}/manual/_output", "./_public/manual"
end

desc "Deploy"
task :deploy do
  Dir.chdir("./_public") do
    system "git add ."
    system "git add -u ."
    system "git commit -m ."
    system "git push origin gh-pages"
  end
end
