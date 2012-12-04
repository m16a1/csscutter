require 'spec_helper'

describe CssCutter::Simplifier do
  subject { CssCutter::Simplifier }
  context '#replace_zeros replace' do
    it 'margin: 0 0 0 0 with margin: 0' do
      code = subject.new 'body{margin: 0 0 0 0}'
      code.replace_zeros.should == 'body{margin:0}'
    end
    it 'margin: 0 0 0 with margin: 0' do
      code = subject.new 'body{margin: 0 0  0}'
      code.replace_zeros.should == 'body{margin:0}'
    end
    it 'margin: 0 0 with margin: 0' do
      code = subject.new 'body{margin: 0 0}'
      code.replace_zeros.should == 'body{margin:0}'
    end
  end
  it '#remove_units_after_zero removes units after zero' do
    code = subject.new 'body{margin:10px 0px}'
    code.remove_units_after_zero.should == 'body{margin:10px 0}'
  end
  it '#convert_rgb_to_hex converts rgb colors to hex' do
    code = subject.new 'a {color: rgb(15, 128, 255)}'
    code.convert_rgb_to_hex.should == 'a {color: #0f80ff}'
  end
end