require 'spec_helper'

describe 'media queries', integration: true do
  let(:cutter) {CssCutter.new }
  it 'single query' do
    code = <<-CSS
      @media all and (min-width: 640px) {
        #media-queries-1 {
          background-color: #0f0;
        }
      }
    CSS
    cutter.optimize(code).should == '@media all and (min-width:640px){#media-q'\
      'ueries-1{background-color:#0f0}}'
  end
  it 'many queries' do
    code = <<-CSS
      @media only all and (max-width: 50em), only all and (max-device-width: 800px) {
        div {
          display: block;
        }
      }
    CSS
    cutter.optimize(code).should == '@media only all and (max-width:50em),only'\
     ' all and (max-device-width:800px){div{display:block}}'
  end
end