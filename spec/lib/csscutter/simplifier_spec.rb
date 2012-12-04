require 'spec_helper'

describe CssCutter::Simplifier do
  subject { CssCutter::Simplifier }
  context 'replace' do
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
  it 'removes units after zero' do
    code = subject.new 'body{margin:10px 0px}'
    code.remove_units_after_zero.should == 'body{margin:10px 0}'
  end
end