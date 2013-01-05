require 'spec_helper'

describe 'important comments', integration: true do
  let(:cutter) {CssCutter.new keep_important_comments: true}
  it 'unchanged when options[:keep_important_comments] is true' do
    cutter.optimize('a{color:/*! red */black}').should == 'a{color:/*! red */black}'
  end
  it 'contents inside important comment' do
    code = 'div{contents:/*! contents: "something" */"some text"}'
    cutter.optimize(code).should == code
  end
  it 'important comment inside contents' do
    code = 'div{contents:"/*! text */"}'
    cutter.optimize(code).should == code
  end
end