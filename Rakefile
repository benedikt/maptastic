require 'rspec/core'
require 'rspec/core/rake_task'
Rspec::Core::RakeTask.new

desc "Generates a sandbox Rails app for testing"
namespace :spec do
  task "sandbox" do
    system "mkdir -p tmp/ && cd tmp && rails sandbox && rm sandbox/Gemfile"
  end
end