require 'spec_helper'

describe 'important comments', integration: true do
  it 'unchanged when options[:keep_important_comments] is true' do
    cutter = CssCutter.new keep_important_comments: true
    cutter.optimize('a{color:/*! red */black}').should == 'a{color:/*! red */black}'
  end
  it 'contents inside important comment' do
    cutter = CssCutter.new keep_important_comments: true
    code = 'div{contents:/*! contents: "something" */"some text"}'
    cutter.optimize(code).should == code
  end
  it 'important comment inside contents' do
    cutter = CssCutter.new keep_important_comments: true
    code = 'div{contents:"/*! text */"}'
    cutter.optimize(code).should == code
  end
end