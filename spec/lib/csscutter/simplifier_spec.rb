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
  context '#minify_hex' do
    it 'converts repeated hex numbers to 3-chars representation' do
      code = subject.new 'a {color: #00ff33}'
      code.minify_hex.should == 'a {color: #0f3}'
    end
    it 'leaves untouched colors like #004733' do
      code = subject.new 'a {color: #004733}'
      code.minify_hex.should == 'a {color: #004733}'
    end
  end
  context '#minify_floats' do
    it 'converts floats like 0.6 to .6' do
      code = subject.new 'a {line-height: 0.2em}'
      code.minify_floats.should == 'a {line-height: .2em}'
    end
    it 'leaves untouched classnames like .a0.6em' do
      code = subject.new '.a0.6em { }'
      code.minify_floats.should == '.a0.6em { }'
    end
  end
  it '#replace_none_value_with_zero replaces something like "border: none" with "border: 0"' do
    code = subject.new 'div {background: none}'
    code.replace_none_value_with_zero.should == 'div {background: 0}'
  end
end