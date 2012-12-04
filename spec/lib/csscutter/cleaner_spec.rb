require 'spec_helper'

describe CssCutter::Cleaner do
  subject { CssCutter::Cleaner }
  context 'remove' do
    it 'unnecessary white space' do
      code = subject.new <<-CSS
      a {
        color: red;
      }
      CSS
      code.remove_whitespace.should == 'a{color:red;}'
    end

    it "doesn't remove space before pseudoselectors" do
      code = subject.new 'a {color: red} u :hover {color: red}'
      code.remove_whitespace.should == 'a{color:red}u :hover{color:red}'
    end

    it 'trailing semicolon' do
      code = subject.new 'a{color:#f00;}'
      code.remove_trailing_semicolons.should == 'a{color:#f00}'
    end

    it 'some of trailing semicolons' do
      code = subject.new 'a{color:#f00;;}'
      code.remove_trailing_semicolons.should == 'a{color:#f00}'
    end

    it 'empty selectors' do
      code = subject.new 'body{color:#000}p { }u{color: #f00}'
      code.remove_empty_selectors.should == 'body{color:#000}u{color: #f00}'
    end

    it 'comments' do
      code = subject.new '/* comment */'
      code.remove_comments.should == ''
    end
  end
end