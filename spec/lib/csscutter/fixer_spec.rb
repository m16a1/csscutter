require 'spec_helper'

describe CssCutter::Fixer do
  subject { CssCutter::Fixer }
  it '#add_missing_semicolons add semicolons between properties' do
    code = subject.new 'a {border: 1px solid red border-radius: red}'
    code.add_missing_semicolons.should == 'a {border: 1px solid red; border-radius: red}'
  end
end