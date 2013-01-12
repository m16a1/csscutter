require 'spec_helper'

describe 'comments', integration: true do
  let(:cutter) { CssCutter.new }
  it 'no whitespace after comments' do
    code = 'a{color: black}/* */ ul{color: red}'
    cutter.optimize(code).should == 'a{color:black}ul{color:red}'
  end
end