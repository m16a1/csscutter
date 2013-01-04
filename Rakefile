require 'bundler'
Bundler.setup

require 'rake'
require 'rspec/core/rake_task'

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

task :gem => :build
task :build do
  system 'gem build csscutter.gemspec'
end

task :install => :build do
  require 'csscutter/version'
  system "sudo gem install csscutter-#{CssCutter::VERSION}.gem"
end

task :clean do
  system 'rm -rf ./coverage/*'
  system 'rmdir ./coverage'
  system 'rm *.gem'
end

task :release => :build do
  require 'csscutter/version'
  system "git tag -a v#{CssCutter::VERSION} -m 'Tagging #{CssCutter::VERSION}'"
  system "git push --tags"
  system "gem push csscutter-#{CssCutter::VERSION}.gem"
  system "rm csscutter-#{CssCutter::VERSION}.gem"
end

RSpec::Core::RakeTask.new('spec') do |spec|
  spec.rspec_opts = %w(--format d --color --profile)
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new('spec:unit') do |spec|
  spec.rspec_opts = %w(--format d --color --profile --tag ~performance --tag ~integration)
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new('spec:performance') do |spec|
  spec.rspec_opts = %w(--format d --color --profile --tag performance)
  spec.pattern = 'spec/performance/*_spec.rb'
end

RSpec::Core::RakeTask.new('spec:integration') do |spec|
  spec.rspec_opts = %w(--format d --color --profile --tag integration)
  spec.pattern = 'spec/integration/*_spec.rb'
end