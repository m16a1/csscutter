require 'spec_helper'

describe CssCutter do
  let(:empty_cleaner) { CssCutter::Cleaner.new('') }
  let(:cleaner) { CssCutter::Cleaner.any_instance }

  let(:empty_simplifier) { CssCutter::Simplifier.new('') }
  let(:simplifier) { CssCutter::Simplifier.any_instance }

  let(:default_cutter) { CssCutter.new }

  context '#clean' do
    it 'calls required cleaner methods' do
      cleaner.should_receive(:remove_whitespace).once.and_return(empty_cleaner)
      cleaner.should_receive(:remove_trailing_semicolons).once.and_return(empty_cleaner)
      cleaner.should_receive(:remove_empty_selectors).once.and_return(empty_cleaner)
      cleaner.should_receive(:remove_comments).once.and_return(empty_cleaner)
      default_cutter.clean ''
    end
  end

  it '#simplify calls all simplifier methods' do
    simplifier.should_receive(:replace_zeros).once.and_return(empty_simplifier)
    simplifier.should_receive(:remove_units_after_zero).once.and_return(empty_simplifier)
    simplifier.should_receive(:convert_rgb_to_hex).once.and_return(empty_simplifier)
    simplifier.should_receive(:minify_hex).once.and_return(empty_simplifier)
    simplifier.should_receive(:minify_floats).once.and_return(empty_simplifier)
    simplifier.should_receive(:replace_none_value_with_zero).once.and_return(empty_simplifier)
    simplifier.should_receive(:minify_font_weight).once.and_return(empty_simplifier)
    default_cutter.simplify ''
  end

  context '#optimize' do
    it 'calls #clean and #simplify methods'do
      default_cutter.should_receive(:clean).once.and_return('')
      default_cutter.should_receive(:simplify).once.and_return('')
      default_cutter.optimize ''
    end
    it 'returns string-compatible value' do
      default_cutter.optimize('').should be_a_kind_of String
    end
  end
end