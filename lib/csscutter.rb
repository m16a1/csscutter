require 'csscutter/version'
require 'csscutter/fixer'
require 'csscutter/cleaner'
require 'csscutter/simplifier'

module CssCutter
  def self.optimize(code)
    simplify clean(fix(code))
  end

  def self.clean(code)
    CssCutter::Cleaner.new(code)
      .remove_whitespace
      .remove_trailing_semicolons
      .remove_comments
      .remove_empty_selectors
  end

  def self.simplify(code)
    CssCutter::Simplifier.new(code)
      .remove_units_after_zero
      .replace_zeros
      .convert_rgb_to_hex
      .minify_hex
      .minify_floats
      .replace_none_value_with_zero
  end

  def self.fix(code)
    CssCutter::Fixer.new(code)
      .add_missing_semicolons
  end
end