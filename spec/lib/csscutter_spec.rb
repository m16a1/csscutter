require 'spec_helper'

describe CssCutter do
  specify { CssCutter.should have_constant(:VERSION) }
  it 'removes comments' do
    cutter = CssCutter.new fixture('comment.css')
    cutter.output.should == fixture('comment.min.css')
  end
end