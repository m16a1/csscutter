require 'spec_helper'

describe CssCutter::WhitespaceKeeper do
  subject { CssCutter::WhitespaceKeeper }
  it 'saves important comments if options[:keep_important_comments] is true' do
    keeper = subject.new '', keep_important_comments: true
    keeper.should_receive(:save_important_comments).once.and_return('')
    keeper.safely_optimize { |code| '' }
  end
  it "doesn't save important comments if options[:keep_important_comments] is true" do
    keeper = subject.new '', keep_important_comments: false
    keeper.should_not_receive(:save_important_comments)
    keeper.safely_optimize { |code| '' }
  end
  it '#save_contents replaces contents property with @@1@@' do
    code = 'div {contents: "some text";display: none}'
    keeper = subject.new code
    keeper.send(:save_contents, code).should == 'div {contents:@@1@@;display: none}'
  end
  it '#save_important_comments replace important comments @@1@@' do
    code = '/*! */div {display: none}'
    keeper = subject.new code
    keeper.send(:save_important_comments, code).should == '@@1@@div {display: none}'
  end
  it '#restore restores all saved comments and contents' do
    code = '@@2@@div {contents:@@1@@; display: none}'
    keeper = subject.new code
    keeper.instance_variable_set :@blocks, [' "some text"', '/*! */']
    keeper.send(:restore, code).should == '/*! */div {contents: "some text"; display: none}'
  end
end