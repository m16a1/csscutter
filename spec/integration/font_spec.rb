require 'spec_helper'

describe 'font', integration: true do
  let(:cutter) { CssCutter.new }
  it 'font-face' do
    code = <<-CSS
      @font-face {
          font-family: "My Font";
          src: url(http://x.xx/my_font.ttf) format("truetype");
      }
    CSS
    cutter.optimize(code).should == '@font-face{font-family:"My Font";src:url('\
      'http://x.xx/my_font.ttf) format("truetype")}'
  end
end