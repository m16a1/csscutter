require 'spec_helper'

describe CssCutter::Cleaner do
  subject { CssCutter::Cleaner }

  context '#remove_whitespace' do
    it 'removes unnecessary white space' do
      code = subject.new <<-CSS
      a {
        color: red ;
        background: white ;
      }
      CSS
      code.remove_whitespace.should == 'a{color:red;background:white;}'
    end
    it "doesn't remove space before pseudoselectors" do
      code = subject.new 'a {color: red} u :hover {color: red}'
      code.remove_whitespace.should == 'a{color:red}u :hover{color:red}'
    end
    it 'removes whitespace in media selectors' do
      code = subject.new '@media all and (min-width: 640px)'
      code.remove_whitespace.should == '@media all and (min-width:640px)'
    end
  end

  context '#remove_trailing_semicolons' do
    it 'removes trailing semicolon' do
      code = subject.new 'a{color:#f00;}'
      code.remove_trailing_semicolons.should == 'a{color:#f00}'
    end
    it 'removes many trailing semicolons' do
      code = subject.new 'a{color:#f00;;}'
      code.remove_trailing_semicolons.should == 'a{color:#f00}'
    end
  end

  context '#remove_empty_selectors' do
    it 'remove empty selectors at beginning' do
      code = subject.new ' p { }u{color: #f00}'
      code.remove_empty_selectors.should == 'u{color: #f00}'
    end
    it 'remove empty selectors at middle' do
      code = subject.new 'body{color:#000}p { }u{color: #f00}'
      code.remove_empty_selectors.should == 'body{color:#000}u{color: #f00}'
    end
  end

  context '#remove_comments' do
    it 'cleanup all comments' do
      code = subject.new '/* comment */'
      code.remove_comments.should == ''
    end
  end
end