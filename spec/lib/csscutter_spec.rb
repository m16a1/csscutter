require 'spec_helper'

describe CssCutter do
  specify { CssCutter.should have_constant(:VERSION) }
  it 'removes unnecessary white space' do
    cutter = CssCutter.new fixture('whitespace.css')
    cutter.output.should == fixture('whitespace.min.css')
  end  
  it 'removes comments' do
    cutter = CssCutter.new fixture('comment.css')
    cutter.output.should == fixture('comment.min.css')
  end
end