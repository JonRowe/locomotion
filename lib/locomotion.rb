require "locomotion/version"

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project config (usually the Rakefile)."
end

Motion::Project::App.setup do |app|

  root = File.join( File.dirname(__FILE__), '../motion' )

  Dir.glob(root+'/**/*.rb').each do |file|
    app.files.unshift(file)
  end

end
