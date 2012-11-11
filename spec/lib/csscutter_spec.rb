require 'spec_helper'

describe CssCutter do
  specify { CssCutter.should have_constant(:VERSION) }
  it 'removes unnecessary white space' do
    cutter = CssCutter.new fixture('whitespace.css')
    cutter.output.should == fixture('whitespace.min.css')
  end
  it 'removes trailing semicolons' do
    cutter = CssCutter.new fixture('semicolon.css')
    cutter.output.should == fixture('semicolon.min.css')
  end
  it 'removes empty selectors' do
    cutter = CssCutter.new fixture('empty_selector.css')
    cutter.output.should == fixture('empty_selector.min.css')
  end
  it 'removes comments' do
    cutter = CssCutter.new fixture('comment.css')
    cutter.output.should == fixture('comment.min.css')
  end
  it 'removes units after zero' do
    cutter = CssCutter.new fixture('zero_and_units.css')
    cutter.output.should == fixture('zero_and_units.min.css')
  end
end