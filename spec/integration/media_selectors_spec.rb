require 'spec_helper'

describe 'media selectors', integration: true do
  let(:cutter) {CssCutter.new }
  it 'optimized fine' do
    code = <<-CSS
      @media all and (min-width: 640px) {
        #media-queries-1 {
          background-color: #0f0;
        }
      }
    CSS
    cutter.optimize(code).should == '@media all and (min-width:640px){#media-queries-1{background-color:#0f0}}'
  end
end