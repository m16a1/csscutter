require 'rspec'
require 'simplecov'
require 'csscutter'

SimpleCov.start do
  add_group 'Libraries', 'lib'
  add_group 'Unit tests', 'spec/unit'
  add_group 'Performance tests', 'spec/performance'
  add_group 'Integration tests', 'spec/integration'
end

RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    (owner.is_a?(Class) ? owner : owner.class).const_defined?(const)
  end
end


