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

  it '#clean calls all cleaner methods' do
    cleaner.should_receive(:remove_whitespace).once
    cleaner.should_receive(:remove_trailing_semicolons).once
    cleaner.should_receive(:remove_empty_selectors).once
    cleaner.should_receive(:remove_comments).once
    cleaner.should_receive(:remove_units_after_zero).once
    CssCutter.clean ''
  end

  it '#simplify calls all simplifier methods' do
    simplifier.should_receive(:replace_zeros).once
    CssCutter.simplify ''
  end

  context '#optimize' do
    it 'calls #clean and #simplifier methods'do
      CssCutter.should_receive(:clean).once.and_return('')
      CssCutter.should_receive(:simplify).once.and_return('')
      CssCutter.optimize ''
    end
    it 'returns string-compatible value' do
      CssCutter.optimize('').should be_a_kind_of String
    end
  end
end