require 'spec_helper'

describe CssCutter do
  let(:empty_cleaner) { CssCutter::Cleaner.new('') }
  let(:cleaner) { CssCutter::Cleaner.any_instance }

  let(:empty_simplifier) { CssCutter::Simplifier.new('') }
  let(:simplifier) { CssCutter::Simplifier.any_instance }

  before do
    cleaner.stub(:remove_whitespace).and_return(empty_cleaner)
    cleaner.stub(:remove_trailing_semicolons).and_return(empty_cleaner)
    cleaner.stub(:remove_empty_selectors).and_return(empty_cleaner)
    cleaner.stub(:remove_comments).and_return(empty_cleaner)
    cleaner.stub(:remove_units_after_zero).and_return(empty_cleaner)
  end

  before do
    simplifier.stub(:replace_zeros).and_return(empty_simplifier)
  end

  it 'calls all cleaner methods' do
    cleaner.should_receive(:remove_whitespace).once
    cleaner.should_receive(:remove_trailing_semicolons).once
    cleaner.should_receive(:remove_empty_selectors).once
    cleaner.should_receive(:remove_comments).once
    cleaner.should_receive(:remove_units_after_zero).once
    CssCutter.run ''
  end

  it 'calls all simplifier methods' do
    simplifier.should_receive(:replace_zeros).once
    CssCutter.run ''
  end

  it '#run should return string-compatible value' do
    CssCutter.run('').should be_a_kind_of String
  end
end