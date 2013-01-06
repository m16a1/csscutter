require 'spec_helper'

describe 'data uri', integration: true do
  let(:cutter) { CssCutter.new }
  it 'works fine' do
    code = <<-CSS
      div { 
        background: url(data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSK);
      }
    CSS
    cutter.optimize(code).should == 'div{background:url(data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSK)}'
  end
end