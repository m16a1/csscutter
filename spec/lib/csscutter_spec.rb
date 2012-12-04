require 'spec_helper'

describe CssCutter do
  let(:empty_cleaner) { CssCutter::Cleaner.new('') }
  let(:cleaner) { CssCutter::Cleaner.any_instance }

  let(:empty_simplifier) { CssCutter::Simplifier.new('') }
  let(:simplifier) { CssCutter::Simplifier.any_instance }

  let(:empty_fixer) { CssCutter::Fixer.new('') }
  let(:fixer) { CssCutter::Fixer.any_instance }

  it '#clean calls all cleaner methods' do
    cleaner.should_receive(:remove_whitespace).once.and_return(empty_cleaner)
    cleaner.should_receive(:remove_trailing_semicolons).once.and_return(empty_cleaner)
    cleaner.should_receive(:remove_empty_selectors).once.and_return(empty_cleaner)
    cleaner.should_receive(:remove_comments).once.and_return(empty_cleaner)
    CssCutter.clean ''
  end

  it '#simplify calls all simplifier methods' do
    simplifier.should_receive(:replace_zeros).once.and_return(empty_simplifier)
    simplifier.should_receive(:remove_units_after_zero).once.and_return(empty_simplifier)
    simplifier.should_receive(:convert_rgb_to_hex).once.and_return(empty_simplifier)
    CssCutter.simplify ''
  end

  it '#fix calls all fixer methods' do
    fixer.should_receive(:add_missing_semicolons).once.and_return(empty_fixer)
    CssCutter.fix ''
  end

  context '#optimize' do
    it 'calls #clean, #simplifier and #fix methods'do
      CssCutter.should_receive(:clean).once.and_return('')
      CssCutter.should_receive(:simplify).once.and_return('')
      CssCutter.should_receive(:fix).once.and_return('')
      CssCutter.optimize ''
    end
    it 'returns string-compatible value' do
      CssCutter.optimize('').should be_a_kind_of String
    end
  end
end