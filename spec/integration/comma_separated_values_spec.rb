require 'spec_helper'

describe 'comma separated values', integration: true do
  let(:cutter) { CssCutter.new }
  it 'works fine' do
    code = <<-CSS
      div { 
        box-shadow: 10px 10px #888, -10px -10px #f4f4f4, 0px 0px 5px 5px #cc6600;
      }
    CSS
    cutter.optimize(code).should == 'div{box-shadow:10px 10px #888,-10px -10px #f4f4f4,0 0 5px 5px #c60}'
  end
end