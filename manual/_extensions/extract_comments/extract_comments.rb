class Hyde::CLI
  task :update do
    require File.expand_path('../lib/extractor', __FILE__)

    Dir.chdir(Hyde.project.root) {
      FileUtils.rm_rf './api'

      ex = Extractor.new Dir['../lib/**/*.rb']

      ex.write!('./api') { |b| puts "   update  *  api/#{b.file}" }
    }
  end

  task.description = "Extracts inline documentation."
end
