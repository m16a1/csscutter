require 'csscutter/version'
require 'csscutter/cleaner'
require 'csscutter/simplifier'

module CssCutter
  def self.run(code)
    clean_code = CssCutter::Cleaner.new(code)
      .remove_whitespace
      .remove_trailing_semicolons
      .remove_empty_selectors
      .remove_comments
      .remove_units_after_zero
    CssCutter::Simplifier.new(clean_code)
      .replace_zeros
  end
end