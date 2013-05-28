require "bundler/gem_tasks"
require 'dotenv'
Dotenv.load

$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

$:.unshift("./lib/")
require './lib/locomotion'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Locomotion'
  app.identifier = 'com.locomotion.test'
  app.deployment_target = "5.1"
end
