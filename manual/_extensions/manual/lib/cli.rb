class Proton::CLI
  task :update do
    require File.expand_path('../extractor', __FILE__)

    Dir.chdir(Hyde.project.root) {
      Proton.project.config.extractor.files.each { |group|
        FileUtils.rm_rf group.target

        ex = Extractor.new Dir[group.source]

        ex.write!(group.target) { |b| puts "   update  *  #{File.join(group.target, b.file)}" }
      }
    }
  end

  task.description = "Extracts inline documentation."
end

