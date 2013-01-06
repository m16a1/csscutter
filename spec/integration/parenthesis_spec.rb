require 'spec_helper'

describe 'filters', integration: true do
  let(:cutter) { CssCutter.new }
  it 'works fine' do
    code = <<-CSS
      div { 
        -webkit-filter: grayscale( 100% );
      }
    CSS
    cutter.optimize(code).should == 'div{-webkit-filter:grayscale(100%)}';
  end
end