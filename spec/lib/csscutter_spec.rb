require 'spec_helper'

describe CssCutter do
  specify { CssCutter.should have_constant(:VERSION) }
  context 'remove' do
    it 'unnecessary white space' do
      cutter = CssCutter.new fixture('whitespace.css')
      cutter.output.should == fixture('whitespace.min.css')
    end
    it 'trailing semicolons' do
      cutter = CssCutter.new fixture('semicolon.css')
      cutter.output.should == fixture('semicolon.min.css')
    end
    it 'empty selectors' do
      cutter = CssCutter.new fixture('empty_selector.css')
      cutter.output.should == fixture('empty_selector.min.css')
    end
    it 'comments' do
      cutter = CssCutter.new fixture('comment.css')
      cutter.output.should == fixture('comment.min.css')
    end
    it 'units after zero' do
      cutter = CssCutter.new fixture('zero_and_units.css')
      cutter.output.should == fixture('zero_and_units.min.css')
    end
  end
  context 'replace' do
    it 'margin: 0 0 0 0 with margin: 0' do
      cutter = CssCutter.new 'body{margin: 0 0 0 0}'
      cutter.output.should == 'body{margin:0}'
    end
    it 'margin: 0 0 0 with margin: 0' do
      cutter = CssCutter.new 'body{margin: 0 0 0}'
      cutter.output.should == 'body{margin:0}'
    end
    it 'margin: 0 0 with margin: 0' do
      cutter = CssCutter.new 'body{margin: 0 0}'
      cutter.output.should == 'body{margin:0}'
    end
  end
end